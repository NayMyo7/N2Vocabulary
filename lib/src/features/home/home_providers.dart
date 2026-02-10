import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/paginated_result.dart';
import '../../domain/models/vocabulary.dart';
import '../../state/providers.dart';

part 'home_providers.g.dart';

@riverpod
Future<List<Vocabulary>> vocabularyByWeekDay(
  Ref ref,
  int week,
  int day,
) async {
  final repository = ref.read(repositoryProvider);

  final result = await repository.retrieveVocabularyPaginated(
    pagination: const PaginationParams(pageSize: 1000),
    filters: VocabularySearchFilters(week: week, day: day),
  );
  return result.items;
}

/// Provider that combines lesson selection with vocabulary data
@riverpod
Future<List<Vocabulary>> dayWords(Ref ref) async {
  final selection = await ref.watch(lessonSelectionProvider.future);
  return ref.watch(
    vocabularyByWeekDayProvider(selection.week, selection.day).future,
  );
}
