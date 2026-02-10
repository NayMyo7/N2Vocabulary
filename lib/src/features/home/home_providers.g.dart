// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vocabularyByWeekDay)
final vocabularyByWeekDayProvider = VocabularyByWeekDayFamily._();

final class VocabularyByWeekDayProvider extends $FunctionalProvider<
        AsyncValue<List<Vocabulary>>,
        List<Vocabulary>,
        FutureOr<List<Vocabulary>>>
    with $FutureModifier<List<Vocabulary>>, $FutureProvider<List<Vocabulary>> {
  VocabularyByWeekDayProvider._(
      {required VocabularyByWeekDayFamily super.from,
      required (
        int,
        int,
      )
          super.argument})
      : super(
          retry: null,
          name: r'vocabularyByWeekDayProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vocabularyByWeekDayHash();

  @override
  String toString() {
    return r'vocabularyByWeekDayProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vocabulary>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vocabulary>> create(Ref ref) {
    final argument = this.argument as (
      int,
      int,
    );
    return vocabularyByWeekDay(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VocabularyByWeekDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vocabularyByWeekDayHash() =>
    r'a14600f1e9cea0cf783a9a47433f858d5657c411';

final class VocabularyByWeekDayFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<Vocabulary>>,
            (
              int,
              int,
            )> {
  VocabularyByWeekDayFamily._()
      : super(
          retry: null,
          name: r'vocabularyByWeekDayProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  VocabularyByWeekDayProvider call(
    int week,
    int day,
  ) =>
      VocabularyByWeekDayProvider._(argument: (
        week,
        day,
      ), from: this);

  @override
  String toString() => r'vocabularyByWeekDayProvider';
}

/// Provider that combines lesson selection with vocabulary data

@ProviderFor(dayWords)
final dayWordsProvider = DayWordsProvider._();

/// Provider that combines lesson selection with vocabulary data

final class DayWordsProvider extends $FunctionalProvider<
        AsyncValue<List<Vocabulary>>,
        List<Vocabulary>,
        FutureOr<List<Vocabulary>>>
    with $FutureModifier<List<Vocabulary>>, $FutureProvider<List<Vocabulary>> {
  /// Provider that combines lesson selection with vocabulary data
  DayWordsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dayWordsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dayWordsHash();

  @$internal
  @override
  $FutureProviderElement<List<Vocabulary>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vocabulary>> create(Ref ref) {
    return dayWords(ref);
  }
}

String _$dayWordsHash() => r'43da2769b446ac610ef6aa4ea6c516ffae4e1de5';
