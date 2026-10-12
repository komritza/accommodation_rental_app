import 'package:accommodation_core/accommodation_core.dart';

enum GuestTab { explore, saved, profile }

List<GuestTab> guestTabsFor(TenantPermissions permissions) {
  return [
    GuestTab.explore,
    if (permissions.favourites) GuestTab.saved,
    GuestTab.profile,
  ];
}
