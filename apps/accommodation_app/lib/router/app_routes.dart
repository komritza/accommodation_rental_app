abstract final class AppRouteNames {
  static const splash = 'splash';
  static const auth = 'auth';
  static const clientHome = 'clientHome';
  static const clientSaved = 'clientSaved';
  static const clientProfile = 'clientProfile';
  static const hostHome = 'hostHome';
  static const hostProfile = 'hostProfile';
  static const sessionRestoreError = 'sessionRestoreError';
  static const guestListingDetail = 'guestListingDetail';
  static const hostListingDetail = 'hostListingDetail';
  static const hostListingDetailEdit = 'hostListingDetailEdit';
  static const hostBlockedDays = 'hostBlockedDays';
}

abstract final class AppRoutePaths {
  static const splash = '/';
  static const auth = '/auth';
  static const clientHome = '/client';
  static const clientSaved = '/client/saved';
  static const clientProfile = '/client/profile';
  static const hostHome = '/host';
  static const hostProfile = '/host/profile';
  static const sessionRestoreError = '/session-restore';
  static String guestListingDetail(String listingId) => '/listing/$listingId';
  static String hostListingDetail(String listingId) =>
      '/host/listings/$listingId';
  static String hostListingDetailEdit(String listingId) =>
      '/host/listings/$listingId/edit';
  static String hostBlockedDays(String listingId) =>
      '/host/listings/$listingId/blocked-days';
}
