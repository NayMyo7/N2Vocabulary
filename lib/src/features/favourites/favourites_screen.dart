import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/vocabulary_state_notifier.dart';
import '../../utils/word_info_snackbar.dart';
import '../../widgets/widgets.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({super.key});

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    // Load initial favourites on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(vocabularyStateProvider.notifier).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyState = ref.watch(vocabularyStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: vocabularyState.favorites.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No favourites yet.'));
          }

          return WordListView(
            words: favorites,
            emptyText: 'No favourites yet.',
            onWordLongPress: (word) => WordInfoSnackBar.show(context, word),
            onToggleFavorite: (word) {
              ref.read(vocabularyStateProvider.notifier).toggleFavorite(word);
            },
          );
        },
      ),
      bottomNavigationBar: const AdBanner(),
    );
  }
}
