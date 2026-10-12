// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_calendar.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(guestCalendarToday)
final guestCalendarTodayProvider = GuestCalendarTodayProvider._();

final class GuestCalendarTodayProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
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
