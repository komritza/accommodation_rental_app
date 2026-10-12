// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_listing_filters.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The filters currently applied to the guest's listing results.

@ProviderFor(GuestListingFilters)
final guestListingFiltersProvider = GuestListingFiltersProvider._();

/// The filters currently applied to the guest's listing results.
final class GuestListingFiltersProvider
    extends $NotifierProvider<GuestListingFilters, ListingSearchQuery> {
  /// The filters currently applied to the guest's listing results.
  GuestListingFiltersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestListingFiltersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestListingFiltersHash();

  @$internal
  @override
  GuestListingFilters create() => GuestListingFilters();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingSearchQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingSearchQuery>(value),
    );
  }
}

String _$guestListingFiltersHash() =>
    r'b07f2e1cc207530dfdddbf92310a1c4ec98c559a';

/// The filters currently applied to the guest's listing results.

abstract class _$GuestListingFilters extends $Notifier<ListingSearchQuery> {
  ListingSearchQuery build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ListingSearchQuery, ListingSearchQuery>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListingSearchQuery, ListingSearchQuery>,
              ListingSearchQuery,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
