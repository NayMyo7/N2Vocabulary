import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../domain/models/vocabulary.dart';
import '../../state/providers.dart';
import '../../state/vocabulary_state_notifier.dart';
import '../../utils/word_info_snackbar.dart';
import '../../widgets/widgets.dart';

class StudyTab extends ConsumerStatefulWidget {
  const StudyTab({super.key});

  @override
  ConsumerState<StudyTab> createState() => _StudyTabState();
}

class _StudyTabState extends ConsumerState<StudyTab> {
  bool _isShuffled = false;
  List<Vocabulary>? _shuffledWords;

  @override
  void initState() {
    super.initState();
    // Load initial data when widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDataForCurrentSelection();
    });
  }

  void _loadDataForCurrentSelection() {
    final lessonSelection = ref.read(lessonSelectionProvider);
    if (lessonSelection.hasValue) {
      final selection = lessonSelection.value!;
      ref
          .read(vocabularyStateProvider.notifier)
          .loadDayWords(selection.week, selection.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyState = ref.watch(vocabularyStateProvider);

    // Load data whenever lesson selection changes
    ref.listen(lessonSelectionProvider, (_, next) {
      if (next.hasValue) {
        final selection = next.value!;
        ref
            .read(vocabularyStateProvider.notifier)
            .loadDayWords(selection.week, selection.day);
      }
    });

    return vocabularyState.dayWords.when(
      data: (dayWords) {
        return Column(
          children: [
            // Word count row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.list_alt,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${dayWords.length} ${dayWords.length == 1 ? 'word' : 'words'}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const Spacer(),
                  // Shuffle button
                  InkWell(
                    onTap: () => _toggleShuffle(dayWords),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isShuffled
                                ? Icons.shuffle_rounded
                                : Icons.shuffle_outlined,
                            size: 16,
                            color: _isShuffled
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Shuffle',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: _isShuffled
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Word list
            Expanded(
              child: WordListView(
                words: _getWordsToDisplay(dayWords),
                emptyText: 'No vocabulary.',
                onWordLongPress: (vocab) =>
                    WordInfoSnackBar.show(context, vocab),
                onToggleFavorite: (vocab) {
                  ref
                      .read(vocabularyStateProvider.notifier)
                      .toggleFavorite(vocab);
                  // Also update shuffled list if in shuffle mode for immediate UI update
                  _updateShuffledWordsFavoriteStatus(
                      vocab.id,
                      vocab.copyWith(
                        favourite: vocab.isFavourite ? 0 : 1,
                      ));
                },
              ),
            ),
          ],
        );
      },
      loading: () {
        // Show immediate UI with loading indicator
        return const Column(
          children: [
            // Placeholder word count row
            SizedBox(
              height: 60,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            // Placeholder content
            Expanded(
              child: Center(
                child: Text('Loading vocabulary...'),
              ),
            ),
          ],
        );
      },
      error: (e, st) {
        return ErrorView(message: e.toString());
      },
    );
  }

  void _toggleShuffle(List<Vocabulary> dayWords) {
    setState(() {
      if (_isShuffled) {
        // Restore original order
        _isShuffled = false;
        _shuffledWords = null;
      } else {
        // Store shuffled list once
        _shuffledWords = List<Vocabulary>.from(dayWords)..shuffle();
        _isShuffled = true;
      }
    });
  }

  void _updateShuffledWordsFavoriteStatus(
      int vocabularyId, Vocabulary updatedVocabulary) {
    if (_isShuffled && _shuffledWords != null) {
      final index = _shuffledWords!.indexWhere((v) => v.id == vocabularyId);
      if (index != -1) {
        _shuffledWords![index] = updatedVocabulary;
      }
    }
  }

  List<Vocabulary> _getWordsToDisplay(List<Vocabulary> dayWords) {
    if (!_isShuffled || _shuffledWords == null) {
      return dayWords;
    }

    // Return the pre-shuffled list to maintain consistent order
    return _shuffledWords!;
  }
}
