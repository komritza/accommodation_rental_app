import 'package:accommodation_core/accommodation_core.dart';

const validTenantRuntimeConfigJson = <String, dynamic>{
  'slug': 'alpine',
  'name': 'Alpine',
  'currency': 'EUR',
  'locales': ['en', 'de'],
  'defaultLocale': 'en',
  'supportEmail': 'support@alpine.example',
  'termsOfUseUrl': 'https://example.com/terms',
  'privacyPolicyUrl': 'https://example.com/privacy',
  'permissions': {
    'hostPanel': true,
    'favourites': true,
    'reviews': true,
    'blockedDays': true,
  },
  'theme': {
    'light': {
      'surface-primary': '#FFFFFF',
      'surface-secondary': '#F5F5F5',
      'surface-action': '#3366FF',
      'text-default': '#111111',
      'text-muted': '#666666',
      'text-on-action': '#FFFFFF',
      'border-primary': '#DDDDDD',
      'icon-action': '#3366FF',
    },
    'dark': {
      'surface-primary': '#111111',
      'surface-secondary': '#222222',
      'surface-action': '#7799FF',
      'text-default': '#FFFFFF',
      'text-muted': '#AAAAAA',
      'text-on-action': '#111111',
      'border-primary': '#444444',
      'icon-action': '#7799FF',
    },
  },
};

TenantRuntimeConfig createTestTenantRuntimeConfig() {
  return TenantRuntimeConfig.fromJson(validTenantRuntimeConfigJson);
}
