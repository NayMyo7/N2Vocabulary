import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/core.dart';
import '../domain/models/vocabulary.dart';
import 'word_list_item.dart';

/// A vocabulary list view with infinite scroll pagination support
class PaginatedWordListView extends ConsumerStatefulWidget {
  const PaginatedWordListView({
    required this.words,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    super.key,
    this.emptyText,
    this.onWordLongPress,
    this.onToggleFavorite,
  });

  final List<Vocabulary> words;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final String? emptyText;
  final void Function(Vocabulary word)? onWordLongPress;
  final void Function(Vocabulary word)? onToggleFavorite;

  @override
  ConsumerState<PaginatedWordListView> createState() =>
      _PaginatedWordListViewState();
}

class _PaginatedWordListViewState extends ConsumerState<PaginatedWordListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200px from bottom
      if (widget.hasMore && !widget.isLoadingMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty && !widget.isLoadingMore) {
      return Center(child: Text(widget.emptyText ?? 'No words.'));
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: widget.words.length + (widget.hasMore ? 1 : 0),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 0.5, color: Color(0xFF1A1A1A)),
      itemBuilder: (context, index) {
        if (index >= widget.words.length) {
          // Loading indicator at the bottom
          return const Padding(
            padding: EdgeInsets.all(AppSizes.lg),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final w = widget.words[index];
        return WordListItem(
          word: w,
          onLongPress: widget.onWordLongPress,
          onToggleFavorite: widget.onToggleFavorite,
        );
      },
    );
  }
}
