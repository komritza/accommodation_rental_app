// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_bookings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HostBookingsController)
final hostBookingsControllerProvider = HostBookingsControllerFamily._();

final class HostBookingsControllerProvider
    extends $AsyncNotifierProvider<HostBookingsController, HostBookingsState> {
  HostBookingsControllerProvider._({
    required HostBookingsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hostBookingsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hostBookingsControllerHash();

  @override
  String toString() {
    return r'hostBookingsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HostBookingsController create() => HostBookingsController();

  @override
  bool operator ==(Object other) {
    return other is HostBookingsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hostBookingsControllerHash() =>
    r'91c73800046eac8ba731eda43e27b8844a021b28';

final class HostBookingsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          HostBookingsController,
          AsyncValue<HostBookingsState>,
          HostBookingsState,
          FutureOr<HostBookingsState>,
          String
        > {
  HostBookingsControllerFamily._()
    : super(
        retry: null,
        name: r'hostBookingsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HostBookingsControllerProvider call(String listingId) =>
      HostBookingsControllerProvider._(argument: listingId, from: this);

  @override
  String toString() => r'hostBookingsControllerProvider';
}

abstract class _$HostBookingsController
    extends $AsyncNotifier<HostBookingsState> {
  late final _$args = ref.$arg as String;
  String get listingId => _$args;

  FutureOr<HostBookingsState> build(String listingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HostBookingsState>, HostBookingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HostBookingsState>, HostBookingsState>,
              AsyncValue<HostBookingsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
