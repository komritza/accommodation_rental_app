abstract final class ApiPaths {
  // Auth
  static const authLogin = '/auth/login';
  static const authRegister = '/auth/register';
  static const authLogout = '/auth/logout';
  static const authMe = '/auth/me';

  // Fav
  static const favourites = '/favourites';
  static String favourite(String listingId) => '/favourites/$listingId';

  // Listings
  static const listings = '/listings';
  static const listingsFacets = '/listings/facets';
  static String listingDetails(String id) => '/listings/$id';
  static String listingDetailsAvailability(String id) =>
      '/listings/$id/availability';

  // Host Listings
  static const hostListings = '/host/listings';
  static String hostListing(String id) => '/host/listings/$id';
  static String hostListingBookings(String listingId) =>
      '/host/listings/$listingId/bookings';
  static String hostListingBlockedDays(String listingId) =>
      '/host/listings/$listingId/blocked-days';
  static String hostListingBlockedDay(String listingId, String date) =>
      '/host/listings/$listingId/blocked-days/$date';

  // Config
  static String tenantRuntimeConfig(String tenant) =>
      '/tenants/$tenant/runtime-config';
}
