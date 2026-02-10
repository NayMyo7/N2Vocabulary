// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider extends $FunctionalProvider<
        AsyncValue<SharedPreferences>,
        SharedPreferences,
        FutureOr<SharedPreferences>>
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  SharedPreferencesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sharedPreferencesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'6c03b929f567eb6f97608f6208b95744ffee3bfd';

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

final class DatabaseProvider extends $FunctionalProvider<
    N2VocabularyDatabase,
    N2VocabularyDatabase,
    N2VocabularyDatabase> with $Provider<N2VocabularyDatabase> {
  DatabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'databaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<N2VocabularyDatabase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  N2VocabularyDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(N2VocabularyDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<N2VocabularyDatabase>(value),
    );
  }
}

String _$databaseHash() => r'9994bf141ef8ca5e58749c191754a7f9a3058879';

@ProviderFor(repository)
final repositoryProvider = RepositoryProvider._();

final class RepositoryProvider extends $FunctionalProvider<
    N2VocabularyRepository,
    N2VocabularyRepository,
    N2VocabularyRepository> with $Provider<N2VocabularyRepository> {
  RepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'repositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$repositoryHash();

  @$internal
  @override
  $ProviderElement<N2VocabularyRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  N2VocabularyRepository create(Ref ref) {
    return repository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(N2VocabularyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<N2VocabularyRepository>(value),
    );
  }
}

String _$repositoryHash() => r'2f4f4563692d86dfec167bf36ef4c90ecf0e6b44';

@ProviderFor(vocabularyActions)
final vocabularyActionsProvider = VocabularyActionsProvider._();

final class VocabularyActionsProvider extends $FunctionalProvider<
    VocabularyActions,
    VocabularyActions,
    VocabularyActions> with $Provider<VocabularyActions> {
  VocabularyActionsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vocabularyActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vocabularyActionsHash();

  @$internal
  @override
  $ProviderElement<VocabularyActions> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VocabularyActions create(Ref ref) {
    return vocabularyActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VocabularyActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VocabularyActions>(value),
    );
  }
}

String _$vocabularyActionsHash() => r'5a5d8cadf44a76ae0e53a60cb3258800fced590d';

@ProviderFor(favouriteVocabulary)
final favouriteVocabularyProvider = FavouriteVocabularyProvider._();

final class FavouriteVocabularyProvider extends $FunctionalProvider<
        AsyncValue<List<Vocabulary>>,
        List<Vocabulary>,
        FutureOr<List<Vocabulary>>>
    with $FutureModifier<List<Vocabulary>>, $FutureProvider<List<Vocabulary>> {
  FavouriteVocabularyProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favouriteVocabularyProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favouriteVocabularyHash();

  @$internal
  @override
  $FutureProviderElement<List<Vocabulary>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vocabulary>> create(Ref ref) {
    return favouriteVocabulary(ref);
  }
}

String _$favouriteVocabularyHash() =>
    r'22640fa7ed732d472ad9ca8458ed5aab6ae08397';

@ProviderFor(vocabularyById)
final vocabularyByIdProvider = VocabularyByIdFamily._();

final class VocabularyByIdProvider extends $FunctionalProvider<
        AsyncValue<Vocabulary?>, Vocabulary?, FutureOr<Vocabulary?>>
    with $FutureModifier<Vocabulary?>, $FutureProvider<Vocabulary?> {
  VocabularyByIdProvider._(
      {required VocabularyByIdFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'vocabularyByIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vocabularyByIdHash();

  @override
  String toString() {
    return r'vocabularyByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Vocabulary?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Vocabulary?> create(Ref ref) {
    final argument = this.argument as int;
    return vocabularyById(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VocabularyByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vocabularyByIdHash() => r'19f74c31c0326c0764c082e2708bd5c02fcc86c1';

final class VocabularyByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Vocabulary?>, int> {
  VocabularyByIdFamily._()
      : super(
          retry: null,
          name: r'vocabularyByIdProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  VocabularyByIdProvider call(
    int vocabularyId,
  ) =>
      VocabularyByIdProvider._(argument: vocabularyId, from: this);

  @override
  String toString() => r'vocabularyByIdProvider';
}

/// Retrieve questions by week and day

@ProviderFor(questionsByWeekAndDay)
final questionsByWeekAndDayProvider = QuestionsByWeekAndDayFamily._();

/// Retrieve questions by week and day

final class QuestionsByWeekAndDayProvider extends $FunctionalProvider<
        AsyncValue<List<Question>>, List<Question>, FutureOr<List<Question>>>
    with $FutureModifier<List<Question>>, $FutureProvider<List<Question>> {
  /// Retrieve questions by week and day
  QuestionsByWeekAndDayProvider._(
      {required QuestionsByWeekAndDayFamily super.from,
      required (
        int,
        int,
      )
          super.argument})
      : super(
          retry: null,
          name: r'questionsByWeekAndDayProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$questionsByWeekAndDayHash();

  @override
  String toString() {
    return r'questionsByWeekAndDayProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Question>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Question>> create(Ref ref) {
    final argument = this.argument as (
      int,
      int,
    );
    return questionsByWeekAndDay(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionsByWeekAndDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$questionsByWeekAndDayHash() =>
    r'c089b06ae3d41b19bc9c9ff0d63cd3c7abf5375b';

/// Retrieve questions by week and day

final class QuestionsByWeekAndDayFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<Question>>,
            (
              int,
              int,
            )> {
  QuestionsByWeekAndDayFamily._()
      : super(
          retry: null,
          name: r'questionsByWeekAndDayProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Retrieve questions by week and day

  QuestionsByWeekAndDayProvider call(
    int week,
    int day,
  ) =>
      QuestionsByWeekAndDayProvider._(argument: (
        week,
        day,
      ), from: this);

  @override
  String toString() => r'questionsByWeekAndDayProvider';
}

@ProviderFor(LessonSelection)
final lessonSelectionProvider = LessonSelectionProvider._();

final class LessonSelectionProvider
    extends $AsyncNotifierProvider<LessonSelection, LessonSelectionData> {
  LessonSelectionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lessonSelectionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lessonSelectionHash();

  @$internal
  @override
  LessonSelection create() => LessonSelection();
}

String _$lessonSelectionHash() => r'183408e98e30850df6bc0caf0fe338e5dd7ec188';

abstract class _$LessonSelection extends $AsyncNotifier<LessonSelectionData> {
  FutureOr<LessonSelectionData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LessonSelectionData>, LessonSelectionData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<LessonSelectionData>, LessonSelectionData>,
        AsyncValue<LessonSelectionData>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
