import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../state/providers.dart';
import '../../utils/furigana_util.dart';
import '../../widgets/widgets.dart';
import 'week_day_data.dart';
import 'flashcards_tab.dart';
import 'home_providers.dart';
import 'lesson_drawer.dart';
import 'quiz_tab.dart';
import 'study_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();

  String _screenTitle(int week, int day) {
    final weekTitle = weekTitles[week - 1];
    final dayTitle = dayTitlesByWeek[week - 1][day - 1];
    final mTitle = '$week-$day ${_extractDayTitle(dayTitle)}';
    return furiganaOriginalText(mTitle.isNotEmpty ? mTitle : weekTitle);
  }

  String _extractDayTitle(String raw) {
    // Find the end of the day prefix like "1{日目;にちめ} " or "10{日目;にちめ} "
    final prefixEnd = raw.indexOf(' ');
    if (prefixEnd != -1) {
      return raw.substring(prefixEnd + 1);
    }
    return raw;
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _tabIndex = 0;
  int _previousDay = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectionAsync = ref.watch(lessonSelectionProvider);

    return selectionAsync.when(
      loading: () {
        // Show immediate loading UI instead of white screen
        return Scaffold(
          appBar: AppBar(
            title: Text('Loading...'),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (e, st) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: ErrorView(message: e.toString()),
        );
      },
      data: (selection) {
        final title = widget._screenTitle(selection.week, selection.day);
        final isDay7 = selection.day == 7;

        // Auto-switch to quiz tab when Day 7 is selected
        if (isDay7 && _previousDay != 7) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _tabIndex = 2);
            }
          });
        }
        _previousDay = selection.day;

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Text(title),
          ),
          drawer: LessonDrawer(
            currentWeek: selection.week,
            currentDay: selection.day,
            onSelect: (w, d) async {
              if (w == selection.week && d == selection.day) {
                if (context.mounted) Navigator.of(context).pop();
                return;
              }
              await ref.read(lessonSelectionProvider.notifier).setWeekDay(w, d);
              setState(() => _tabIndex = 0);
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
          body: _MainBody(
            tabIndex: isDay7 ? 2 : _tabIndex,
            dayOfCourse: selection.dayOfCourse,
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AdBanner(useSafeArea: false),
              BottomNavigationBar(
                currentIndex: _tabIndex,
                onTap: isDay7
                    ? null
                    : (index) => setState(() => _tabIndex = index),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book,
                        color: isDay7 ? Colors.grey : null),
                    label: 'Study',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.style, color: isDay7 ? Colors.grey : null),
                    label: 'Flash Card',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.quiz),
                    label: 'Quiz',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MainBody extends ConsumerWidget {
  const _MainBody({required this.tabIndex, required this.dayOfCourse});

  final int tabIndex;
  final int dayOfCourse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tabIndex == 0) {
      return const StudyTab();
    }

    final dayWordsAsync = ref.watch(dayWordsProvider);
    return dayWordsAsync.when(
      data: (dayWords) {
        if (tabIndex == 1) {
          return FlashcardsTab(words: dayWords);
        }
        return const QuizTab();
      },
      error: (e, st) => ErrorView(message: e.toString()),
      loading: () => const LoadingIndicator(),
    );
  }
}
