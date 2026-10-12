import 'package:accommodation_app/router/guest_tabs.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_test/flutter_test.dart';

TenantPermissions _permissions({required bool favourites}) {
  return TenantPermissions(
    hostPanel: true,
    favourites: favourites,
    reviews: true,
    blockedDays: true,
  );
}

void main() {
  test('includes the saved tab only when favourites are enabled', () {
    expect(guestTabsFor(_permissions(favourites: true)), [
      GuestTab.explore,
      GuestTab.saved,
      GuestTab.profile,
    ]);
    expect(guestTabsFor(_permissions(favourites: false)), [
      GuestTab.explore,
      GuestTab.profile,
    ]);
  });
}
