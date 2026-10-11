import 'package:accommodation_core/accommodation_core.dart';

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

TenantRuntimeConfig createTestConfig({
  TenantLocale defaultLocale = TenantLocale.en,
}) {
  const palette = ThemePalette(
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
    slug: TenantSlug.alpine,
    name: 'Alpine',
    currency: 'EUR',
    locales: const [TenantLocale.en, TenantLocale.de],
    defaultLocale: defaultLocale,
    supportEmail: 'support@alpine.example',
    termsOfUseUrl: 'https://example.com/terms',
    privacyPolicyUrl: 'https://example.com/privacy',
    permissions: const TenantPermissions(
      hostPanel: true,
      favourites: true,
      reviews: true,
      blockedDays: true,
    ),
    theme: const TenantTheme(light: palette, dark: darkPalette),
  );
}
