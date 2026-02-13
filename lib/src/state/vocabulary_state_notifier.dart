import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/models/models.dart';
import 'providers.dart';

part 'vocabulary_state_notifier.g.dart';

/// Unified vocabulary state management across all screens
class VocabularyState {
  const VocabularyState({
    this.dayWords = const AsyncValue.loading(),
    this.favorites = const AsyncValue.loading(),
    this.searchResults = const AsyncValue.loading(),
  });

  final AsyncValue<List<Vocabulary>> dayWords;
  final AsyncValue<List<Vocabulary>> favorites;
  final AsyncValue<List<Vocabulary>> searchResults;

  VocabularyState copyWith({
    AsyncValue<List<Vocabulary>>? dayWords,
    AsyncValue<List<Vocabulary>>? favorites,
    AsyncValue<List<Vocabulary>>? searchResults,
  }) {
    return VocabularyState(
      dayWords: dayWords ?? this.dayWords,
      favorites: favorites ?? this.favorites,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

@riverpod
class VocabularyStateNotifier extends _$VocabularyStateNotifier {
  @override
  VocabularyState build() {
    return const VocabularyState();
  }

  /// Load day words for specific week and day
  Future<void> loadDayWords(int week, int day) async {
    state = state.copyWith(dayWords: const AsyncValue.loading());

    try {
      final repository = ref.read(repositoryProvider);
      final result = await repository.retrieveVocabularyPaginated(
        pagination: const PaginationParams(pageSize: 1000),
        filters: VocabularySearchFilters(week: week, day: day),
      );

      state = state.copyWith(dayWords: AsyncValue.data(result.items));
    } catch (e, stackTrace) {
      state = state.copyWith(dayWords: AsyncValue.error(e, stackTrace));
    }
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(favorites: const AsyncValue.loading());

    try {
      final repository = ref.read(repositoryProvider);
      final result = await repository.retrieveFavouriteVocabularyPaginated(
        pagination: const PaginationParams(pageSize: 1000),
      );

      state = state.copyWith(favorites: AsyncValue.data(result.items));
    } catch (e, stackTrace) {
      state = state.copyWith(favorites: AsyncValue.error(e, stackTrace));
    }
  }

  /// Load search results
  Future<void> loadSearchResults({
    String? query,
    int? week,
    int? day,
    bool? favouritesOnly,
  }) async {
    state = state.copyWith(searchResults: const AsyncValue.loading());

    try {
      final repository = ref.read(repositoryProvider);
      final filters = VocabularySearchFilters(
        query: query?.trim().toLowerCase(),
        week: week,
        day: day,
        favouritesOnly: favouritesOnly ?? false,
      );

      final result = await repository.retrieveVocabularyPaginated(
        pagination: const PaginationParams(pageSize: 1000),
        filters: filters,
      );

      state = state.copyWith(searchResults: AsyncValue.data(result.items));
    } catch (e, stackTrace) {
      state = state.copyWith(searchResults: AsyncValue.error(e, stackTrace));
    }
  }

  /// Toggle favorite status with optimistic updates and rollback
  Future<void> toggleFavorite(Vocabulary vocabulary) async {
    // Create optimistic update
    final updatedVocabulary = vocabulary.copyWith(
      favourite: vocabulary.isFavourite ? 0 : 1,
    );

    // Store previous state for potential rollback
    final previousState = state;

    // Update all relevant lists optimistically
    _updateVocabularyInAllLists(vocabulary.id, updatedVocabulary);

    try {
      // Perform the actual database operation
      final repository = ref.read(repositoryProvider);

      if (vocabulary.isFavourite) {
        await repository.removeFavourite(vocabulary.id);
      } else {
        await repository.markFavourite(vocabulary.id);
      }

      // Invalidate only specific providers for consistency
      ref.invalidate(vocabularyByIdProvider(vocabulary.id));

      // Note: We don't automatically refresh lists to avoid performance issues
      // The optimistic updates already provide immediate UI feedback
      // Data will be refreshed when user navigates back to screens
    } catch (e) {
      // Rollback on error
      state = previousState;
      rethrow;
    }
  }

  /// Update vocabulary in all relevant lists
  void _updateVocabularyInAllLists(
      int vocabularyId, Vocabulary updatedVocabulary) {
    state = state.copyWith(
      dayWords: _updateVocabularyInList(
          state.dayWords, vocabularyId, updatedVocabulary),
      favorites: _updateVocabularyInList(
          state.favorites, vocabularyId, updatedVocabulary),
      searchResults: _updateVocabularyInList(
          state.searchResults, vocabularyId, updatedVocabulary),
    );
  }

  /// Update a single vocabulary item in a list
  AsyncValue<List<Vocabulary>> _updateVocabularyInList(
    AsyncValue<List<Vocabulary>> listAsync,
    int vocabularyId,
    Vocabulary updatedVocabulary,
  ) {
    if (listAsync is! AsyncData) return listAsync;

    final currentList = listAsync.value ?? [];
    final index = currentList.indexWhere((v) => v.id == vocabularyId);

    if (index == -1) return listAsync;

    final updatedList = List<Vocabulary>.from(currentList);
    updatedList[index] = updatedVocabulary;

    return AsyncValue.data(updatedList);
  }

  /// Refresh day words only
  Future<void> refreshDayWords() async {
    final lessonSelection = ref.read(lessonSelectionProvider);
    if (lessonSelection.hasValue) {
      final selection = lessonSelection.value!;
      await loadDayWords(selection.week, selection.day);
    }
  }

  /// Refresh favorites only
  Future<void> refreshFavorites() async {
    await loadFavorites();
  }
}
