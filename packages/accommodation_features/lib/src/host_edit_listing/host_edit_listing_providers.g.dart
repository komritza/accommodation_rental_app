// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_edit_listing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HostEditListingController)
final hostEditListingControllerProvider = HostEditListingControllerFamily._();

final class HostEditListingControllerProvider
    extends
        $AsyncNotifierProvider<
          HostEditListingController,
          HostEditListingState
        > {
  HostEditListingControllerProvider._({
    required HostEditListingControllerFamily super.from,
    required (String, {String language}) super.argument,
  }) : super(
         retry: null,
         name: r'hostEditListingControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hostEditListingControllerHash();

  @override
  String toString() {
    return r'hostEditListingControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  HostEditListingController create() => HostEditListingController();

  @override
  bool operator ==(Object other) {
    return other is HostEditListingControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hostEditListingControllerHash() =>
    r'492e6b97a513556d304d13f9a6cd1e59063f1dfc';

final class HostEditListingControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          HostEditListingController,
          AsyncValue<HostEditListingState>,
          HostEditListingState,
          FutureOr<HostEditListingState>,
          (String, {String language})
        > {
  HostEditListingControllerFamily._()
    : super(
        retry: null,
        name: r'hostEditListingControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HostEditListingControllerProvider call(
    String listingId, {
    required String language,
  }) => HostEditListingControllerProvider._(
    argument: (listingId, language: language),
    from: this,
  );

  @override
  String toString() => r'hostEditListingControllerProvider';
}

abstract class _$HostEditListingController
    extends $AsyncNotifier<HostEditListingState> {
  late final _$args = ref.$arg as (String, {String language});
  String get listingId => _$args.$1;
  String get language => _$args.language;

  FutureOr<HostEditListingState> build(
    String listingId, {
    required String language,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<HostEditListingState>, HostEditListingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<HostEditListingState>,
                HostEditListingState
              >,
              AsyncValue<HostEditListingState>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(_$args.$1, language: _$args.language),
    );
  }
}
