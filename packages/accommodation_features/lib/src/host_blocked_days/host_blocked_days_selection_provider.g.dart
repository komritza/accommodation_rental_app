// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_blocked_days_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HostBlockedDaysSelection)
final hostBlockedDaysSelectionProvider = HostBlockedDaysSelectionFamily._();

final class HostBlockedDaysSelectionProvider
    extends
        $NotifierProvider<
          HostBlockedDaysSelection,
          HostBlockedDaysSelectionState
        > {
  HostBlockedDaysSelectionProvider._({
    required HostBlockedDaysSelectionFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hostBlockedDaysSelectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hostBlockedDaysSelectionHash();

  @override
  String toString() {
    return r'hostBlockedDaysSelectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HostBlockedDaysSelection create() => HostBlockedDaysSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HostBlockedDaysSelectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HostBlockedDaysSelectionState>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HostBlockedDaysSelectionProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hostBlockedDaysSelectionHash() =>
    r'8dec6cb4479eb8546406402e382ca1ba34ddafaf';

final class HostBlockedDaysSelectionFamily extends $Family
    with
        $ClassFamilyOverride<
          HostBlockedDaysSelection,
          HostBlockedDaysSelectionState,
          HostBlockedDaysSelectionState,
          HostBlockedDaysSelectionState,
          String
        > {
  HostBlockedDaysSelectionFamily._()
    : super(
        retry: null,
        name: r'hostBlockedDaysSelectionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HostBlockedDaysSelectionProvider call(String listingId) =>
      HostBlockedDaysSelectionProvider._(argument: listingId, from: this);

  @override
  String toString() => r'hostBlockedDaysSelectionProvider';
}

abstract class _$HostBlockedDaysSelection
    extends $Notifier<HostBlockedDaysSelectionState> {
  late final _$args = ref.$arg as String;
  String get listingId => _$args;

  HostBlockedDaysSelectionState build(String listingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              HostBlockedDaysSelectionState,
              HostBlockedDaysSelectionState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                HostBlockedDaysSelectionState,
                HostBlockedDaysSelectionState
              >,
              HostBlockedDaysSelectionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
