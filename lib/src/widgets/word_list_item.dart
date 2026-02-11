import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/core.dart';
import '../core/theme/app_text_styles.dart';
import '../domain/models/vocabulary.dart';
import '../services/tts_provider.dart';
import 'furigana_text.dart';

class WordListItem extends ConsumerWidget {
  const WordListItem(
      {required this.word, this.onLongPress, this.onToggleFavorite, super.key});

  final Vocabulary word;
  final void Function(Vocabulary word)? onLongPress;
  final void Function(Vocabulary word)? onToggleFavorite;

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
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
            furiganaStyle: const TextStyle(
              fontSize: 10,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            word.burmese,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.burmeseText.copyWith(
              color: const Color(0xFF212121),
            ),
          ),
        ],
      ),
      trailing: WordTrailingActions(
        word: word,
        onToggleFavorite: onToggleFavorite,
      ),
    );
  }
}

class WordTrailingActions extends StatefulWidget {
  const WordTrailingActions({
    required this.word,
    this.onToggleFavorite,
    super.key,
  });

  final Vocabulary word;
  final void Function(Vocabulary word)? onToggleFavorite;

  @override
  State<WordTrailingActions> createState() => _WordTrailingActionsState();
}

class _WordTrailingActionsState extends State<WordTrailingActions> {
  bool _isFavourite = false;
  bool _isUpdating = false;
  DateTime? _lastTapTime;

  @override
  void initState() {
    super.initState();
    _isFavourite = widget.word.isFavourite;
  }

  @override
  void didUpdateWidget(WordTrailingActions oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Always update local state when widget updates to ensure synchronization
    if (oldWidget.word.id != widget.word.id ||
        oldWidget.word.isFavourite != widget.word.isFavourite) {
      setState(() {
        _isFavourite = widget.word.isFavourite;
        _isUpdating = false;
      });
    }
  }

  void _handleToggle() {
    if (_isUpdating) return; // Prevent multiple taps

    // Add debouncing to prevent rapid successive taps
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!).inMilliseconds < 300) {
      return; // Ignore taps within 300ms of previous tap
    }
    _lastTapTime = now;

    setState(() {
      _isFavourite = !_isFavourite;
      _isUpdating = true;
    });

    // Call the actual toggle function
    widget.onToggleFavorite?.call(widget.word);
  }

  @override
  Widget build(BuildContext context) {
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
              tooltip: _isFavourite ? 'Remove favourite' : 'Add favourite',
              padding: EdgeInsets.zero,
              visualDensity: AppSizes.compactIconDensity,
              constraints: AppSizes.iconButtonTightConstraints,
              icon: Icon(
                _isFavourite ? Icons.star : Icons.star_border,
                size: AppSizes.iconSizeSm,
                color: _isFavourite
                    ? AppColors.favouriteActive
                    : AppColors.favouriteInactive,
              ),
              onPressed: _handleToggle,
            ),
          ),
          const SizedBox(height: AppSizes.xxs),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
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
                    final kanji = widget.word.kanji.trim();
                    final kana = tts.sanitizeKana(widget.word.furigana);
                    final text = kanji.isNotEmpty ? kanji : kana;
                    tts.speak(text);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
