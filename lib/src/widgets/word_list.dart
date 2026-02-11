import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:n2vocabulary/src/core/theme/app_colors.dart';

import '../domain/models/vocabulary.dart';
import 'word_list_item.dart';

class WordListView extends ConsumerWidget {
  const WordListView({
    required this.words,
    super.key,
    this.emptyText,
    this.onWordLongPress,
    this.onToggleFavorite,
  });

  final List<Vocabulary> words;
  final String? emptyText;
  final void Function(Vocabulary word)? onWordLongPress;
  final void Function(Vocabulary word)? onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (words.isEmpty) {
      return Center(child: Text(emptyText ?? 'No words.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 50),
      itemCount: words.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 1, color: AppColors.divider),
      itemBuilder: (context, index) {
        final w = words[index];
        return WordListItem(
          key: ValueKey(w.id),
          word: w,
          onLongPress: onWordLongPress,
          onToggleFavorite: onToggleFavorite,
        );
      },
    );
  }
}
