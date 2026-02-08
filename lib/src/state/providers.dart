import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/n2_vocabulary_database.dart';
import '../data/repositories/n2_vocabulary_repository.dart';
import '../domain/models/vocabulary.dart';

part 'providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
N2VocabularyDatabase database(Ref ref) {
  final db = N2VocabularyDatabase();
  ref.onDispose(db.close);
  return db;
}

@riverpod
N2VocabularyRepository repository(Ref ref) {
  return N2VocabularyRepository(ref.watch(databaseProvider));
}

@riverpod
class VocabularyStore extends _$VocabularyStore {
  @override
  Future<List<Vocabulary>> build() async {
    return ref.watch(repositoryProvider).retrieveAllVocabulary();
  }

  Future<void> toggleFavourite(Vocabulary vocabulary) async {
    final repo = ref.read(repositoryProvider);

    if (vocabulary.isFavourite) {
      await repo.removeFavourite(vocabulary.id);
    } else {
      await repo.markFavourite(vocabulary.id);
    }

    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (current == null) {
      state = AsyncData(await repo.retrieveAllVocabulary());
      return;
    }

    state = AsyncData(
      current
          .map(
            (v) => v.id == vocabulary.id
                ? v.copyWith(favourite: vocabulary.isFavourite ? 0 : 1)
                : v,
          )
          .toList(growable: false),
    );
  }
}

@riverpod
List<Vocabulary>? allVocabularyValue(Ref ref) {
  return ref.watch(vocabularyStoreProvider.select((v) => switch (v) {
        AsyncData(:final value) => value,
        _ => null,
      }));
}

@riverpod
List<Vocabulary> favouriteVocabularyValue(Ref ref) {
  final vocabulary = ref.watch(allVocabularyValueProvider);
  if (vocabulary == null) return const <Vocabulary>[];
  return vocabulary.where((v) => v.isFavourite).toList(growable: false);
}

@riverpod
AsyncValue<List<Vocabulary>> favouriteVocabulary(Ref ref) {
  final all = ref.watch(vocabularyStoreProvider);
  return all.whenData(
    (vocabulary) =>
        vocabulary.where((v) => v.isFavourite).toList(growable: false),
  );
}

@riverpod
AsyncValue<Vocabulary?> vocabularyById(Ref ref, int vocabularyId) {
  final all = ref.watch(vocabularyStoreProvider);
  return all.whenData((vocabulary) {
    for (final v in vocabulary) {
      if (v.id == vocabularyId) return v;
    }
    return null;
  });
}

@riverpod
Vocabulary? vocabularyByIdValue(Ref ref, int vocabularyId) {
  final vocabulary =
      ref.watch(vocabularyStoreProvider.select((v) => switch (v) {
            AsyncData(:final value) => value,
            _ => null,
          }));
  if (vocabulary == null) return null;
  for (final v in vocabulary) {
    if (v.id == vocabularyId) return v;
  }
  return null;
}

class LessonSelectionData {
  const LessonSelectionData({
    required this.week,
    required this.day,
    required this.position,
  });

  final int week;
  final int day;
  final int position;

  int get dayOfCourse => (week - 1) * 7 + day;

  LessonSelectionData copyWith({int? week, int? day, int? position}) {
    return LessonSelectionData(
      week: week ?? this.week,
      day: day ?? this.day,
      position: position ?? this.position,
    );
  }
}

@riverpod
class LessonSelection extends _$LessonSelection {
  static const _kWeek = 'WEEK';
  static const _kDay = 'DAY';
  static const _kPosition = 'POSITION';

  @override
  Future<LessonSelectionData> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return LessonSelectionData(
      week: prefs.getInt(_kWeek) ?? 1,
      day: prefs.getInt(_kDay) ?? 1,
      position: prefs.getInt(_kPosition) ?? 0,
    );
  }

  Future<void> setWeekDay(int week, int day) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setInt(_kWeek, week);
    await prefs.setInt(_kDay, day);
    await prefs.setInt(_kPosition, 0);
    state = AsyncData(LessonSelectionData(week: week, day: day, position: 0));
  }

  Future<void> setPosition(int position) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final current =
        state.value ?? const LessonSelectionData(week: 1, day: 1, position: 0);
    await prefs.setInt(_kPosition, position);
    state = AsyncData(current.copyWith(position: position));
  }
}
