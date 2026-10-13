// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_listings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HostListingsController)
final hostListingsControllerProvider = HostListingsControllerProvider._();

final class HostListingsControllerProvider
    extends $AsyncNotifierProvider<HostListingsController, HostListingsState> {
  HostListingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hostListingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hostListingsControllerHash();

  @$internal
  @override
  HostListingsController create() => HostListingsController();
}

String _$hostListingsControllerHash() =>
    r'17e6e6c05732732e9e1183f56bd81079c1dc6bfb';

abstract class _$HostListingsController
    extends $AsyncNotifier<HostListingsState> {
  FutureOr<HostListingsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HostListingsState>, HostListingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HostListingsState>, HostListingsState>,
              AsyncValue<HostListingsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
