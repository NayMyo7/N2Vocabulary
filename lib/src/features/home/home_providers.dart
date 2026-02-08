import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/vocabulary.dart';
import '../../state/providers.dart';

part 'home_providers.g.dart';

@riverpod
AsyncValue<List<Vocabulary>> dayWords(Ref ref) {
  final selection = ref.watch(lessonSelectionProvider);
  final all = ref.watch(vocabularyStoreProvider);

  return selection.when(
    data: (s) {
      return all.whenData(
        (vocabulary) => vocabulary
            .where((v) => v.day == s.day && v.week == s.week)
            .toList(growable: false),
      );
    },
    error: (e, st) => AsyncValue.error(e, st),
    loading: () => const AsyncValue.loading(),
  );
}
