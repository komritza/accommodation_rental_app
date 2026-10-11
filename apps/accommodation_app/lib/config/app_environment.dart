import 'package:accommodation_core/accommodation_core.dart';

const _tenantSlugValue = String.fromEnvironment('TENANT_SLUG');

const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

TenantSlug tenantFromEnvironment() {
  return switch (_tenantSlugValue) {
    'alpine' => TenantSlug.alpine,
    'riviera' => TenantSlug.riviera,
    _ => throw StateError(
      'Invalid TENANT_SLUG. Set it to "alpine" or "riviera".',
    ),
  };
}
