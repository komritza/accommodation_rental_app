// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_filter_draft.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GuestFilterDraft)
final guestFilterDraftProvider = GuestFilterDraftProvider._();

final class GuestFilterDraftProvider
    extends $NotifierProvider<GuestFilterDraft, GuestFilterDraftState> {
  GuestFilterDraftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestFilterDraftProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestFilterDraftHash();

  @$internal
  @override
  GuestFilterDraft create() => GuestFilterDraft();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuestFilterDraftState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuestFilterDraftState>(value),
    );
  }
}

String _$guestFilterDraftHash() => r'877f5a5049001c71a28fdfa6ca0ae6faa75d8370';

abstract class _$GuestFilterDraft extends $Notifier<GuestFilterDraftState> {
  GuestFilterDraftState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GuestFilterDraftState, GuestFilterDraftState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GuestFilterDraftState, GuestFilterDraftState>,
              GuestFilterDraftState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(guestFilterResultCount)
final guestFilterResultCountProvider = GuestFilterResultCountProvider._();

final class GuestFilterResultCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  GuestFilterResultCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestFilterResultCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestFilterResultCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return guestFilterResultCount(ref);
  }
}

String _$guestFilterResultCountHash() =>
    r'51a60c20b369909fe2a20d232b33c905056d27eb';
