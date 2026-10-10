import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/tenant_runtime_config_fixture.dart';

void main() {
  group('TenantRuntimeConfig', () {
    test('parses JSON into the expected model', () {
      final config = TenantRuntimeConfig.fromJson(validTenantRuntimeConfigJson);

      expect(config.slug, TenantSlug.alpine);
      expect(config.name, 'Alpine');
      expect(config.currency, 'EUR');
      expect(config.locales, [TenantLocale.en, TenantLocale.de]);
      expect(config.defaultLocale, TenantLocale.en);

      expect(config.permissions.hostPanel, isTrue);
      expect(config.permissions.favourites, isTrue);
      expect(config.permissions.reviews, isTrue);
      expect(config.permissions.blockedDays, isTrue);

      expect(config.theme.light.surfacePrimary, '#FFFFFF');
      expect(config.theme.dark.surfacePrimary, '#111111');
    });

    test('serializes the model back to JSON', () {
      final config = TenantRuntimeConfig.fromJson(validTenantRuntimeConfigJson);

      expect(config.toJson(), equals(validTenantRuntimeConfigJson));
    });
  });
}
