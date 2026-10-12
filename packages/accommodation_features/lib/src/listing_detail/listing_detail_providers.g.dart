// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listingDetail)
final listingDetailProvider = ListingDetailFamily._();

final class ListingDetailProvider
    extends $FunctionalProvider<AsyncValue<Listing>, Listing, FutureOr<Listing>>
    with $FutureModifier<Listing>, $FutureProvider<Listing> {
  ListingDetailProvider._({
    required ListingDetailFamily super.from,
    required (String, {String language}) super.argument,
  }) : super(
         retry: null,
         name: r'listingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listingDetailHash();

  @override
  String toString() {
    return r'listingDetailProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Listing> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Listing> create(Ref ref) {
    final argument = this.argument as (String, {String language});
    return listingDetail(ref, argument.$1, language: argument.language);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listingDetailHash() => r'37b6335aa2d60e4e8109b7f8effbdbe12e6df71b';

final class ListingDetailFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Listing>,
          (String, {String language})
        > {
  ListingDetailFamily._()
    : super(
        retry: null,
        name: r'listingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListingDetailProvider call(String listingId, {required String language}) =>
      ListingDetailProvider._(
        argument: (listingId, language: language),
        from: this,
      );

  @override
  String toString() => r'listingDetailProvider';
}

@ProviderFor(listingAvailability)
final listingAvailabilityProvider = ListingAvailabilityFamily._();

final class ListingAvailabilityProvider
    extends
        $FunctionalProvider<
          AsyncValue<ListingAvailability>,
          ListingAvailability,
          FutureOr<ListingAvailability>
        >
    with
        $FutureModifier<ListingAvailability>,
        $FutureProvider<ListingAvailability> {
  ListingAvailabilityProvider._({
    required ListingAvailabilityFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listingAvailabilityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listingAvailabilityHash();

  @override
  String toString() {
    return r'listingAvailabilityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ListingAvailability> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ListingAvailability> create(Ref ref) {
    final argument = this.argument as String;
    return listingAvailability(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingAvailabilityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listingAvailabilityHash() =>
    r'2890a85321c94503b0d00e88db46126da414ebda';

final class ListingAvailabilityFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ListingAvailability>, String> {
  ListingAvailabilityFamily._()
    : super(
        retry: null,
        name: r'listingAvailabilityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListingAvailabilityProvider call(String listingId) =>
      ListingAvailabilityProvider._(argument: listingId, from: this);

  @override
  String toString() => r'listingAvailabilityProvider';
}
