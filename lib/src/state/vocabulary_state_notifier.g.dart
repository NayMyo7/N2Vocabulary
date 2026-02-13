// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VocabularyStateNotifier)
final vocabularyStateProvider = VocabularyStateNotifierProvider._();

final class VocabularyStateNotifierProvider
    extends $NotifierProvider<VocabularyStateNotifier, VocabularyState> {
  VocabularyStateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vocabularyStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vocabularyStateNotifierHash();

  @$internal
  @override
  VocabularyStateNotifier create() => VocabularyStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VocabularyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VocabularyState>(value),
    );
  }
}

String _$vocabularyStateNotifierHash() =>
    r'a9ac346075a9a077583e1b7f861c673b95714f24';

abstract class _$VocabularyStateNotifier extends $Notifier<VocabularyState> {
  VocabularyState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VocabularyState, VocabularyState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<VocabularyState, VocabularyState>,
        VocabularyState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
