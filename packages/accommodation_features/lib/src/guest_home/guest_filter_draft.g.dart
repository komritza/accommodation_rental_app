// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_filter_draft.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The first day a stay can start on.

@ProviderFor(guestCalendarToday)
final guestCalendarTodayProvider = GuestCalendarTodayProvider._();

/// The first day a stay can start on.

final class GuestCalendarTodayProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// The first day a stay can start on.
  GuestCalendarTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestCalendarTodayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestCalendarTodayHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return guestCalendarToday(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$guestCalendarTodayHash() =>
    r'f9d6050d52ffb8e9f96aa3df5a3b403d906c8316';

/// The filters being edited in the filter sheet. Starts from the applied
/// filters each time the sheet opens and is discarded when it closes.

@ProviderFor(GuestFilterDraft)
final guestFilterDraftProvider = GuestFilterDraftProvider._();

/// The filters being edited in the filter sheet. Starts from the applied
/// filters each time the sheet opens and is discarded when it closes.
final class GuestFilterDraftProvider
    extends $NotifierProvider<GuestFilterDraft, GuestFilterDraftState> {
  /// The filters being edited in the filter sheet. Starts from the applied
  /// filters each time the sheet opens and is discarded when it closes.
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

/// The filters being edited in the filter sheet. Starts from the applied
/// filters each time the sheet opens and is discarded when it closes.

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

/// How many listings the draft filters would show.

@ProviderFor(guestFilterResultCount)
final guestFilterResultCountProvider = GuestFilterResultCountProvider._();

/// How many listings the draft filters would show.

final class GuestFilterResultCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// How many listings the draft filters would show.
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
