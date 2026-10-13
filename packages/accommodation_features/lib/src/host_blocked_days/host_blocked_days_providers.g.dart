// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_blocked_days_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hostBlockedDays)
final hostBlockedDaysProvider = HostBlockedDaysFamily._();

final class HostBlockedDaysProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BlockedDay>>,
          List<BlockedDay>,
          FutureOr<List<BlockedDay>>
        >
    with $FutureModifier<List<BlockedDay>>, $FutureProvider<List<BlockedDay>> {
  HostBlockedDaysProvider._({
    required HostBlockedDaysFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hostBlockedDaysProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hostBlockedDaysHash();

  @override
  String toString() {
    return r'hostBlockedDaysProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BlockedDay>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BlockedDay>> create(Ref ref) {
    final argument = this.argument as String;
    return hostBlockedDays(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HostBlockedDaysProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hostBlockedDaysHash() => r'ea7295b38473470a55f6539013fad410ac4e1fbf';

final class HostBlockedDaysFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BlockedDay>>, String> {
  HostBlockedDaysFamily._()
    : super(
        retry: null,
        name: r'hostBlockedDaysProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HostBlockedDaysProvider call(String listingId) =>
      HostBlockedDaysProvider._(argument: listingId, from: this);

  @override
  String toString() => r'hostBlockedDaysProvider';
}

@ProviderFor(HostBlockedDaysController)
final hostBlockedDaysControllerProvider = HostBlockedDaysControllerFamily._();

final class HostBlockedDaysControllerProvider
    extends $AsyncNotifierProvider<HostBlockedDaysController, void> {
  HostBlockedDaysControllerProvider._({
    required HostBlockedDaysControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hostBlockedDaysControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hostBlockedDaysControllerHash();

  @override
  String toString() {
    return r'hostBlockedDaysControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HostBlockedDaysController create() => HostBlockedDaysController();

  @override
  bool operator ==(Object other) {
    return other is HostBlockedDaysControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hostBlockedDaysControllerHash() =>
    r'6dcf8efc3e59af4c3e3c242ee43b33dc360b9ba3';

final class HostBlockedDaysControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          HostBlockedDaysController,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          String
        > {
  HostBlockedDaysControllerFamily._()
    : super(
        retry: null,
        name: r'hostBlockedDaysControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HostBlockedDaysControllerProvider call(String listingId) =>
      HostBlockedDaysControllerProvider._(argument: listingId, from: this);

  @override
  String toString() => r'hostBlockedDaysControllerProvider';
}

abstract class _$HostBlockedDaysController extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as String;
  String get listingId => _$args;

  FutureOr<void> build(String listingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
