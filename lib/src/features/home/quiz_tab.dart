import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../core/core.dart';
import '../../domain/models/question.dart';
import '../../state/providers.dart';

class QuizTab extends ConsumerStatefulWidget {
  const QuizTab({super.key});

  @override
  ConsumerState<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends ConsumerState<QuizTab> {
  final _rng = Random();

  int _score = 0;
  int _questionCount = 0;

  Question? _currentQuestion;
  List<String> _options = const [];
  String? _selected;
  bool _answered = false;

  List<int> _deck = const [];
  int _deckIndex = 0;
  bool _finished = false;
  bool _showingResult = false;

  List<Question> _dayQuestions = [];

  bool get _hasProgress => _questionCount > 0 || _answered || _selected != null;

  bool get _isLastQuestion =>
      _deck.isNotEmpty && _deckIndex == _deck.length - 1;

  ({
    String tier,
    String grade,
    Color scoreColor,
    String lottieAsset,
    String message,
  }) _resultStyleForScore(int percent) {
    if (percent >= 90 && percent <= 100) {
      return (
        tier: 'Platinum',
        grade: 'A',
        scoreColor: const Color(0xFF1B5E20),
        lottieAsset: 'assets/lottie/trophy.json',
        message: 'Excellent!',
      );
    }
    if (percent >= 80 && percent <= 89) {
      return (
        tier: 'Gold',
        grade: 'B',
        scoreColor: const Color(0xFFB8860B),
        lottieAsset: 'assets/lottie/premium.json',
        message: 'Congrats!',
      );
    }
    if (percent >= 60 && percent <= 79) {
      return (
        tier: 'Silver',
        grade: 'C',
        scoreColor: const Color(0xFF1976D2),
        lottieAsset: 'assets/lottie/thumbs_up.json',
        message: 'Well Done!',
      );
    }
    return (
      tier: 'Bronze',
      grade: 'D',
      scoreColor: const Color(0xFFE65100),
      lottieAsset: 'assets/lottie/success_popup.json',
      message: 'Nice Effort!',
    );
  }

  Future<void> _showResultDialog() async {
    final total = _questionCount == 0 ? _dayQuestions.length : _questionCount;
    final percent = total == 0 ? 0 : ((_score / total) * 100).round();
    final style = _resultStyleForScore(percent);

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.lg),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400, minWidth: 320),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.xl * 2,
                    vertical: AppSizes.lg,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: AppSizes.sm),
                      // Lottie animation
                      Transform.scale(
                        scale: 1.5,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Lottie.asset(
                            style.lottieAsset,
                            repeat: true,
                            animate: true,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Text(
                        style.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: AppSizes.md),
                      Text(
                        '$percent% Score',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF10B981),
                                  letterSpacing: -1,
                                ),
                      ),
                      const SizedBox(height: AppSizes.lg),
                      Text(
                        'Quiz completed successfully.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: AppSizes.md),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black87, height: 1.5),
                          children: [
                            const TextSpan(text: 'You attempt '),
                            TextSpan(
                              text: '$total questions',
                              style: const TextStyle(
                                color: Color(0xFF3B82F6),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const TextSpan(text: ' and\nfrom that '),
                            TextSpan(
                              text: '$_score answer',
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const TextSpan(text: ' is correct.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                    ],
                  ),
                ),
                Positioned(
                  top: AppSizes.sm,
                  right: AppSizes.sm,
                  child: IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black54,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _finishQuiz() async {
    if (_finished || _showingResult) return;

    setState(() {
      _finished = true;
      _showingResult = true;
    });

    await _showResultDialog();
    if (!mounted) return;

    // Reset quiz when user closes the dialog.
    setState(() {
      _showingResult = false;
    });
    _restart();
  }

  Future<void> _confirmRestart() async {
    final shouldRestart = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.lg),
          ),
          title: Text(
            'Restart quiz?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          content: Text(
            'Your current progress will be lost.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.lg,
                  vertical: AppSizes.md,
                ),
              ),
              child: Text(
                'Cancel',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.md),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.lg,
                  vertical: AppSizes.md,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Restart',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldRestart == true) {
      _restart();
    }
  }

  void _restart() {
    setState(() {
      _score = 0;
      _questionCount = 0;
      _selected = null;
      _answered = false;
      _currentQuestion = null;
      _rebuildDeck();
    });
    _newQuestion();
  }

  @override
  void initState() {
    super.initState();
  }

  void _initializeQuestions(List<Question> questions) {
    if (_dayQuestions != questions) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _dayQuestions = questions;
          });
          _rebuildDeck();
          _newQuestion();
        }
      });
    }
  }

  void _rebuildDeck() {
    final ids = _dayQuestions.map((q) => q.id).toList(growable: false);
    ids.shuffle(_rng);
    _deck = ids;
    _deckIndex = 0;
    _finished = ids.isEmpty;
  }

  void _newQuestion() {
    if (_dayQuestions.isEmpty) {
      setState(() {
        _finished = true;
        _currentQuestion = null;
        _options = const [];
        _selected = null;
        _answered = false;
      });
      return;
    }

    if (_deck.isEmpty) {
      setState(() {
        _finished = true;
        _currentQuestion = null;
        _options = const [];
        _selected = null;
        _answered = false;
      });
      return;
    }

    if (_deckIndex >= _deck.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _finishQuiz();
      });
      return;
    }

    final questionId = _deck[_deckIndex];
    final question = _dayQuestions.firstWhere((q) => q.id == questionId);
    final optionsList = [...question.options]..shuffle(_rng);

    setState(() {
      _finished = false;
      _currentQuestion = question;
      _options = optionsList;
      _selected = null;
      _answered = false;
    });
  }

  void _select(String value) {
    if (_answered || _currentQuestion == null) return;

    final correctAnswer = _currentQuestion!.correctAnswer;
    final isCorrect = value == correctAnswer;

    setState(() {
      _selected = value;
      _answered = true;
      if (isCorrect) _score += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectionAsync = ref.watch(lessonSelectionProvider);

    return selectionAsync.when(
      data: (selection) {
        final questionsAsync = ref.watch(
          questionsByWeekAndDayProvider(selection.week, selection.day),
        );

        return questionsAsync.when(
          data: (questions) {
            _initializeQuestions(questions);

            if (questions.isEmpty) {
              return const Center(
                child: Text('No questions available for this day.'),
              );
            }

            if (_options.isEmpty || _currentQuestion == null) {
              return const Center(child: Text('Preparing quiz...'));
            }

            return _buildQuizContent(context);
          },
          error: (e, st) => Center(child: Text('Error loading questions: $e')),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
      error: (e, st) => Center(child: Text('Error: $e')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildQuizContent(BuildContext context) {
    final correctAnswer = _currentQuestion!.correctAnswer;
    final questionText = _currentQuestion!.question;
    const prompt = 'Select the correct answer';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${_questionCount + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          TextSpan(
                            text: '/${_dayQuestions.length}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.sm,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            child: LinearProgressIndicator(
              value: _dayQuestions.isEmpty
                  ? 0
                  : (_questionCount) / _dayQuestions.length,
              minHeight: 6,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.md,
          ),
          child: Card(
            elevation: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prompt,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                  ),
                  const SizedBox(height: AppSizes.radiusSm),
                  Text(
                    questionText,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.lg,
              vertical: AppSizes.listTileVerticalPadding,
            ),
            itemCount: _options.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSizes.md),
            itemBuilder: (context, index) {
              final option = _options[index];
              const letters = ['a', 'b', 'c', 'd'];
              final letter = index < letters.length ? letters[index] : '';

              final scheme = Theme.of(context).colorScheme;

              var bg = Colors.transparent;
              var borderColor = scheme.primary.withValues(alpha: 0.45);
              var badgeBg = scheme.primaryContainer;
              var badgeFg = scheme.onPrimaryContainer;

              if (_answered) {
                if (option == correctAnswer) {
                  bg = scheme.primary.withValues(alpha: 0.16);
                  borderColor = scheme.primary;
                  badgeBg = scheme.primary;
                  badgeFg = scheme.onPrimary;
                } else if (option == _selected) {
                  bg = scheme.error.withValues(alpha: 0.15);
                  borderColor = scheme.error;
                  badgeBg = scheme.error;
                  badgeFg = scheme.onError;
                }
              }

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => _select(option),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: borderColor),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                      vertical: AppSizes.s6,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: badgeBg,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            letter,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: badgeFg,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.radiusSm),
                        Expanded(
                          child: Text(
                            option,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: scheme.onSurface,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.secondary.withValues(
                      alpha: 0.5,
                    ),
                    disabledForegroundColor: Colors.white.withValues(
                      alpha: 0.6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.md),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                    elevation: 0,
                  ),
                  onPressed: (_hasProgress && !_showingResult)
                      ? _confirmRestart
                      : null,
                  icon: const Icon(
                    Icons.refresh,
                    size: 22,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Restart',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
                    disabledForegroundColor: Colors.white.withValues(
                      alpha: 0.6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.md),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                    elevation: 2,
                  ),
                  onPressed: (_answered && !_showingResult)
                      ? () {
                          if (_isLastQuestion) {
                            _finishQuiz();
                            return;
                          }
                          setState(() {
                            _questionCount += 1;
                            _deckIndex += 1;
                          });
                          _newQuestion();
                        }
                      : null,
                  icon: Icon(
                    _isLastQuestion ? Icons.check_circle : Icons.navigate_next,
                    size: 22,
                    color: Colors.white,
                  ),
                  label: Text(
                    _isLastQuestion ? 'Finish' : 'Next',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
