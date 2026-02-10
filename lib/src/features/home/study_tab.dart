import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../utils/word_info_snackbar.dart';
import '../../widgets/widgets.dart';
import 'home_providers.dart';

class StudyTab extends ConsumerWidget {
  const StudyTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayWordsAsync = ref.watch(dayWordsProvider);

    return dayWordsAsync.when(
      data: (dayWords) {
        return WordListView(
          words: dayWords,
          emptyText: 'No vocabulary.',
          onWordLongPress: (vocab) => WordInfoSnackBar.show(context, vocab),
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
}
