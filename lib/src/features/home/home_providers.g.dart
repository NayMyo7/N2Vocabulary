// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dayWords)
final dayWordsProvider = DayWordsProvider._();

final class DayWordsProvider extends $FunctionalProvider<
    AsyncValue<List<Vocabulary>>,
    AsyncValue<List<Vocabulary>>,
    AsyncValue<List<Vocabulary>>> with $Provider<AsyncValue<List<Vocabulary>>> {
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
  $ProviderElement<AsyncValue<List<Vocabulary>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<List<Vocabulary>> create(Ref ref) {
    return dayWords(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Vocabulary>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Vocabulary>>>(value),
    );
  }
}

String _$dayWordsHash() => r'b6e662b617e6662e42c3cc004d7272d98d99281c';
