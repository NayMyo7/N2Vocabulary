import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../domain/models/vocabulary.dart';
import '../../utils/word_info_snackbar.dart';
import '../../widgets/widgets.dart';
import 'home_providers.dart';

class StudyTab extends ConsumerStatefulWidget {
  const StudyTab({super.key});

  @override
  ConsumerState<StudyTab> createState() => _StudyTabState();
}

class _StudyTabState extends ConsumerState<StudyTab> {
  List<String>? _originalWords;
  bool _isShuffled = false;

  @override
  Widget build(BuildContext context) {
    final dayWordsAsync = ref.watch(dayWordsProvider);

    return dayWordsAsync.when(
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
              ),
            ),
          ],
        );
      },
      error: (e, st) {
        return ErrorView(message: e.toString());
      },
      loading: () {
        return const LoadingIndicator();
      },
    );
  }

  void _toggleShuffle(List<Vocabulary> dayWords) {
    setState(() {
      if (_isShuffled) {
        // Restore original order
        _isShuffled = false;
      } else {
        // Store original order and shuffle
        _originalWords = dayWords.map((word) => word.id.toString()).toList();
        _isShuffled = true;
      }
    });
  }

  List<Vocabulary> _getWordsToDisplay(List<Vocabulary> dayWords) {
    if (!_isShuffled || _originalWords == null) {
      return dayWords;
    }

    // Create shuffled copy
    final shuffled = List<Vocabulary>.from(dayWords);
    shuffled.shuffle(Random());
    return shuffled;
  }
}
