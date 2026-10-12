// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_listings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GuestListingsController)
final guestListingsControllerProvider = GuestListingsControllerProvider._();

final class GuestListingsControllerProvider
    extends
        $AsyncNotifierProvider<GuestListingsController, GuestListingsState> {
  GuestListingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestListingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestListingsControllerHash();

  @$internal
  @override
  GuestListingsController create() => GuestListingsController();
}

String _$guestListingsControllerHash() =>
    r'aa9b163239961fa32a6971819ecaa515c8a0e22b';

abstract class _$GuestListingsController
    extends $AsyncNotifier<GuestListingsState> {
  FutureOr<GuestListingsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<GuestListingsState>, GuestListingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GuestListingsState>, GuestListingsState>,
              AsyncValue<GuestListingsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
