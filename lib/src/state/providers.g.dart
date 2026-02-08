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
          isAutoDispose: true,
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

String _$databaseHash() => r'535e41f3a606825f5cc8c740e872d0ac428e3699';

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

String _$repositoryHash() => r'dfcf98214315751022601a6a3c31f3666394ce4a';

@ProviderFor(VocabularyStore)
final vocabularyStoreProvider = VocabularyStoreProvider._();

final class VocabularyStoreProvider
    extends $AsyncNotifierProvider<VocabularyStore, List<Vocabulary>> {
  VocabularyStoreProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vocabularyStoreProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vocabularyStoreHash();

  @$internal
  @override
  VocabularyStore create() => VocabularyStore();
}

String _$vocabularyStoreHash() => r'581207311a7e2483126c9060e4743ea0b02fff8a';

abstract class _$VocabularyStore extends $AsyncNotifier<List<Vocabulary>> {
  FutureOr<List<Vocabulary>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Vocabulary>>, List<Vocabulary>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Vocabulary>>, List<Vocabulary>>,
        AsyncValue<List<Vocabulary>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(allVocabularyValue)
final allVocabularyValueProvider = AllVocabularyValueProvider._();

final class AllVocabularyValueProvider extends $FunctionalProvider<
    List<Vocabulary>?,
    List<Vocabulary>?,
    List<Vocabulary>?> with $Provider<List<Vocabulary>?> {
  AllVocabularyValueProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'allVocabularyValueProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$allVocabularyValueHash();

  @$internal
  @override
  $ProviderElement<List<Vocabulary>?> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Vocabulary>? create(Ref ref) {
    return allVocabularyValue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Vocabulary>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Vocabulary>?>(value),
    );
  }
}

String _$allVocabularyValueHash() =>
    r'394faf24a90bc41736e4ad4116643d25567797b2';

@ProviderFor(favouriteVocabularyValue)
final favouriteVocabularyValueProvider = FavouriteVocabularyValueProvider._();

final class FavouriteVocabularyValueProvider extends $FunctionalProvider<
    List<Vocabulary>,
    List<Vocabulary>,
    List<Vocabulary>> with $Provider<List<Vocabulary>> {
  FavouriteVocabularyValueProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favouriteVocabularyValueProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favouriteVocabularyValueHash();

  @$internal
  @override
  $ProviderElement<List<Vocabulary>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Vocabulary> create(Ref ref) {
    return favouriteVocabularyValue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Vocabulary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Vocabulary>>(value),
    );
  }
}

String _$favouriteVocabularyValueHash() =>
    r'61ad618a953153f51d6bcabc1d9d17875e7cab53';

@ProviderFor(favouriteVocabulary)
final favouriteVocabularyProvider = FavouriteVocabularyProvider._();

final class FavouriteVocabularyProvider extends $FunctionalProvider<
    AsyncValue<List<Vocabulary>>,
    AsyncValue<List<Vocabulary>>,
    AsyncValue<List<Vocabulary>>> with $Provider<AsyncValue<List<Vocabulary>>> {
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
  $ProviderElement<AsyncValue<List<Vocabulary>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<Vocabulary>> create(Ref ref) {
    return favouriteVocabulary(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Vocabulary>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Vocabulary>>>(value),
    );
  }
}

String _$favouriteVocabularyHash() =>
    r'54d3f0ed7fe3a5e119fd6fb59eb7044ec8dd023f';

@ProviderFor(vocabularyById)
final vocabularyByIdProvider = VocabularyByIdFamily._();

final class VocabularyByIdProvider extends $FunctionalProvider<
    AsyncValue<Vocabulary?>,
    AsyncValue<Vocabulary?>,
    AsyncValue<Vocabulary?>> with $Provider<AsyncValue<Vocabulary?>> {
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
  $ProviderElement<AsyncValue<Vocabulary?>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<Vocabulary?> create(Ref ref) {
    final argument = this.argument as int;
    return vocabularyById(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Vocabulary?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Vocabulary?>>(value),
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

String _$vocabularyByIdHash() => r'85145cbb876a2fc244aa5ad56130336215677713';

final class VocabularyByIdFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<Vocabulary?>, int> {
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

@ProviderFor(vocabularyByIdValue)
final vocabularyByIdValueProvider = VocabularyByIdValueFamily._();

final class VocabularyByIdValueProvider
    extends $FunctionalProvider<Vocabulary?, Vocabulary?, Vocabulary?>
    with $Provider<Vocabulary?> {
  VocabularyByIdValueProvider._(
      {required VocabularyByIdValueFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'vocabularyByIdValueProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vocabularyByIdValueHash();

  @override
  String toString() {
    return r'vocabularyByIdValueProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Vocabulary?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Vocabulary? create(Ref ref) {
    final argument = this.argument as int;
    return vocabularyByIdValue(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Vocabulary? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Vocabulary?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VocabularyByIdValueProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vocabularyByIdValueHash() =>
    r'e7725fb1ab0b0329208f60a91fd306f8c436c270';

final class VocabularyByIdValueFamily extends $Family
    with $FunctionalFamilyOverride<Vocabulary?, int> {
  VocabularyByIdValueFamily._()
      : super(
          retry: null,
          name: r'vocabularyByIdValueProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  VocabularyByIdValueProvider call(
    int vocabularyId,
  ) =>
      VocabularyByIdValueProvider._(argument: vocabularyId, from: this);

  @override
  String toString() => r'vocabularyByIdValueProvider';
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

String _$lessonSelectionHash() => r'7f35b7b11db6e4b0892fd04464743b0deb0f6d57';

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
