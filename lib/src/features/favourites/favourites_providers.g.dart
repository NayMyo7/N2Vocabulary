// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaginatedFavourites)
final paginatedFavouritesProvider = PaginatedFavouritesProvider._();

final class PaginatedFavouritesProvider
    extends $NotifierProvider<PaginatedFavourites, FavouritesState> {
  PaginatedFavouritesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'paginatedFavouritesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$paginatedFavouritesHash();

  @$internal
  @override
  PaginatedFavourites create() => PaginatedFavourites();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavouritesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavouritesState>(value),
    );
  }
}

String _$paginatedFavouritesHash() =>
    r'5360afbd9c50ed3d26a9708f7a9330d6371c091d';

abstract class _$PaginatedFavourites extends $Notifier<FavouritesState> {
  FavouritesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FavouritesState, FavouritesState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<FavouritesState, FavouritesState>,
        FavouritesState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
