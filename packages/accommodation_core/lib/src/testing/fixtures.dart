import '../../accommodation_core.dart';

TenantRuntimeConfig createTestConfig({
  TenantSlug slug = TenantSlug.alpine,
  TenantLocale defaultLocale = TenantLocale.en,
  TenantPermissions permissions = const TenantPermissions(
    hostPanel: true,
    favourites: true,
    reviews: true,
    blockedDays: true,
  ),
}) {
  const lightPalette = ThemePalette(
    surfacePrimary: '#FFFFFF',
    surfaceSecondary: '#F5F5F5',
    surfaceAction: '#3366FF',
    textDefault: '#111111',
    textMuted: '#666666',
    textOnAction: '#FFFFFF',
    borderPrimary: '#DDDDDD',
    iconAction: '#3366FF',
  );

  const darkPalette = ThemePalette(
    surfacePrimary: '#111111',
    surfaceSecondary: '#222222',
    surfaceAction: '#7799FF',
    textDefault: '#FFFFFF',
    textMuted: '#AAAAAA',
    textOnAction: '#111111',
    borderPrimary: '#444444',
    iconAction: '#7799FF',
  );

  return TenantRuntimeConfig(
    slug: slug,
    name: 'Alpine',
    currency: 'EUR',
    locales: const [TenantLocale.en, TenantLocale.de],
    defaultLocale: defaultLocale,
    supportEmail: 'support@alpine.example',
    termsOfUseUrl: 'https://example.com/terms',
    privacyPolicyUrl: 'https://example.com/privacy',
    permissions: permissions,
    theme: const TenantTheme(light: lightPalette, dark: darkPalette),
  );
}

const testClient = AuthUser(
  id: 'client-1',
  tenantId: 'alpine',
  role: UserRole.client,
  email: 'client@example.com',
  firstName: 'Alex',
  lastName: 'Smith',
);

const testHost = AuthUser(
  id: 'host-1',
  tenantId: 'alpine',
  role: UserRole.host,
  email: 'host@example.com',
  firstName: 'Nina',
  lastName: 'Brunner',
);

Listing createTestListing({
  String id = 'lst_00001',
  String title = 'Sunlit Quarters in Lucerne',
  String city = 'Lucerne',
  int maxGuests = 2,
  num pricePerNight = 173,
  String currency = 'CHF',
  List<String> images = const ['https://example.com/lst_00001.jpg'],
  int bedrooms = 1,
  int beds = 1,
  int bathrooms = 1,
}) {
  return Listing(
    id: id,
    tenantId: 'alpine',
    hostId: 'host-1',
    title: title,
    description: 'A test listing.',
    city: city,
    country: 'CH',
    address: 'Bahnhofstrasse 1',
    latitude: 47.05,
    longitude: 8.29,
    propertyType: 'apartment',
    maxGuests: maxGuests,
    bedrooms: bedrooms,
    beds: beds,
    bathrooms: bathrooms,
    pricePerNight: pricePerNight,
    cleaningFee: 60,
    currency: currency,
    amenities: const ['wifi'],
    rating: 4.5,
    reviewsCount: 10,
    images: images,
    createdAt: DateTime.utc(2026, 1, 1),
  );
}

Booking createTestBooking({
  String id = 'bkg_00001',
  String listingId = 'lst_00001',
  String guestName = 'Lena Graf',
  DateTime? checkIn,
  DateTime? checkOut,
  int guests = 2,
  BookingStatus status = BookingStatus.confirmed,
  num totalPrice = 406,
  String currency = 'CHF',
}) {
  return Booking(
    id: id,
    listingId: listingId,
    guestName: guestName,
    checkIn: checkIn ?? DateTime.utc(2026, 3, 1),
    checkOut: checkOut ?? DateTime.utc(2026, 3, 3),
    guests: guests,
    status: status,
    totalPrice: totalPrice,
    currency: currency,
  );
}

ListingFacets createTestFacets({
  List<String> cities = const ['Lucerne', 'Zermatt'],
  num priceMin = 80,
  num priceMax = 400,
  int maxGuests = 8,
  String currency = 'CHF',
}) {
  return ListingFacets(
    cities: cities,
    propertyTypes: const ['apartment', 'chalet'],
    amenities: const ['wifi'],
    priceMin: priceMin,
    priceMax: priceMax,
    maxGuests: maxGuests,
    currency: currency,
  );
}
