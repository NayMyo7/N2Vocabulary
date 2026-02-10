import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/core.dart';
import '../domain/models/vocabulary.dart';
import '../services/tts_provider.dart';
import '../state/providers.dart';
import 'furigana_text.dart';

class WordListItem extends ConsumerWidget {
  const WordListItem({required this.word, this.onLongPress, super.key});

  final Vocabulary word;
  final void Function(Vocabulary word)? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.listTileVerticalPadding,
        horizontal: AppSizes.listTileHorizontalPadding,
      ),
      onLongPress: onLongPress != null ? () => onLongPress!(word) : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FuriganaText(
            word.japanese,
            baseStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              letterSpacing: 0.2,
            ),
            furiganaStyle: const TextStyle(
              fontSize: 10,
              color: AppColors.primary,
              height: 1.5,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            word.burmese,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
      trailing: WordTrailingActions(word: word),
    );
  }
}

class WordTrailingActions extends ConsumerWidget {
  const WordTrailingActions({required this.word, super.key});

  final Vocabulary word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the vocabulary store to get the latest favourite status
    final currentWordAsync = ref.watch(vocabularyByIdProvider(word.id));
    final currentWord = currentWordAsync.value ?? word;

    return SizedBox(
      width: AppSizes.trailingWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppSizes.iconButtonBox,
            height: AppSizes.iconButtonBox,
            child: IconButton(
              tooltip: currentWord.isFavourite
                  ? 'Remove favourite'
                  : 'Add favourite',
              padding: EdgeInsets.zero,
              visualDensity: AppSizes.compactIconDensity,
              constraints: AppSizes.iconButtonTightConstraints,
              icon: Icon(
                currentWord.isFavourite ? Icons.star : Icons.star_border,
                size: AppSizes.iconSizeSm,
                color: currentWord.isFavourite
                    ? AppColors.favouriteActive
                    : AppColors.favouriteInactive,
              ),
              onPressed: () => ref
                  .read(vocabularyActionsProvider)
                  .toggleFavourite(currentWord),
            ),
          ),
          const SizedBox(height: AppSizes.xxs),
          SizedBox(
            width: AppSizes.iconButtonBox,
            height: AppSizes.iconButtonBox,
            child: IconButton(
              tooltip: 'Speak',
              padding: EdgeInsets.zero,
              visualDensity: AppSizes.compactIconDensity,
              constraints: AppSizes.iconButtonTightConstraints,
              icon: const Icon(
                Icons.volume_up_outlined,
                size: AppSizes.iconSizeSm,
              ),
              onPressed: () {
                final tts = ref.read(ttsServiceProvider);
                final kanji = word.kanji.trim();
                final kana = tts.sanitizeKana(word.furigana);
                final text = kanji.isNotEmpty ? kanji : kana;
                tts.speak(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
