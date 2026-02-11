import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/n2vocabulary_database.dart';
import '../data/repositories/n2vocabulary_repository.dart';
import '../domain/models/paginated_result.dart';
import '../domain/models/question.dart';
import '../domain/models/vocabulary.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  // Cache SharedPreferences instance to avoid repeated initialization
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
N2VocabularyDatabase database(Ref ref) {
  final db = N2VocabularyDatabase();
  ref.onDispose(db.close);
  return db;
}

@riverpod
N2VocabularyRepository repository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return N2VocabularyRepository(db);
}

@Riverpod(keepAlive: true)
VocabularyActions vocabularyActions(Ref ref) {
  return VocabularyActions(ref);
}

class VocabularyActions {
  VocabularyActions(this.ref);

  final Ref ref;

  Future<void> toggleFavourite(Vocabulary vocabulary) async {
    final repo = ref.read(repositoryProvider);

    if (vocabulary.isFavourite) {
      await repo.removeFavourite(vocabulary.id);
    } else {
      await repo.markFavourite(vocabulary.id);
    }

    // Invalidate dependent providers to refresh their data
    ref.invalidate(favouriteVocabularyProvider);
    ref.invalidate(vocabularyByIdProvider(vocabulary.id));
  }
}

@riverpod
Future<List<Vocabulary>> favouriteVocabulary(Ref ref) async {
  final repository = ref.read(repositoryProvider);
  final result = await repository.retrieveFavouriteVocabularyPaginated(
    pagination: const PaginationParams(
        pageSize: 1000), // Load all favourites with reasonable limit
  );
  return result.items;
}

@riverpod
Future<Vocabulary?> vocabularyById(Ref ref, int vocabularyId) async {
  final repository = ref.read(repositoryProvider);
  return repository.retrieveVocabularyById(vocabularyId);
}

/// Retrieve questions by week and day
@riverpod
Future<List<Question>> questionsByWeekAndDay(
  Ref ref,
  int week,
  int day,
) async {
  final repository = ref.read(repositoryProvider);
  return repository.retrieveQuestionsByWeekAndDay(week, day);
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

@Riverpod(keepAlive: true)
class LessonSelection extends _$LessonSelection {
  static const _kWeek = 'WEEK';
  static const _kDay = 'DAY';
  static const _kPosition = 'POSITION';

  @override
  Future<LessonSelectionData> build() async {
    // Use cached SharedPreferences to avoid repeated initialization
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
