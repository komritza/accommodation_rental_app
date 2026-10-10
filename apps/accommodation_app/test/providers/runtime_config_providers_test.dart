import 'dart:async';

import 'package:accommodation_app/providers/runtime_config_providers.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRuntimeConfigRemoteDataSource extends RuntimeConfigRemoteDataSource {
  FakeRuntimeConfigRemoteDataSource(this._fetch) : super(Dio());

  final Future<TenantRuntimeConfig> Function(TenantSlug tenant) _fetch;

  @override
  Future<TenantRuntimeConfig> fetchRuntimeConfig(TenantSlug tenant) {
    return _fetch(tenant);
  }
}

TenantRuntimeConfig createTestConfig() {
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

  return const TenantRuntimeConfig(
    slug: TenantSlug.alpine,
    name: 'Alpine',
    currency: 'EUR',
    locales: [TenantLocale.en, TenantLocale.de],
    defaultLocale: TenantLocale.en,
    supportEmail: '[support@alpine.example](mailto:support@alpine.example)',
    termsOfUseUrl: 'https://example.com/terms',
    privacyPolicyUrl: 'https://example.com/privacy',
    permissions: TenantPermissions(
      hostPanel: true,
      favourites: true,
      reviews: true,
      blockedDays: true,
    ),
    theme: TenantTheme(light: palette, dark: palette),
  );
}

void main() {
  group('runtimeConfigProvider', () {
    test('loads the selected tenant configuration', () async {
      final config = createTestConfig();
      final container = ProviderContainer(
        overrides: [
          tenantSlugProvider.overrideWith((ref) => TenantSlug.alpine),
          runtimeConfigRemoteDataSourceProvider.overrideWith(
            (ref) => FakeRuntimeConfigRemoteDataSource((tenant) async {
              expect(tenant, TenantSlug.alpine);
              return config;
            }),
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(runtimeConfigProvider.future);

      expect(result, config);
    });

    test('exposes a load exception when the request fails', () async {
      final container = ProviderContainer(
        overrides: [
          tenantSlugProvider.overrideWith((ref) => TenantSlug.alpine),
          runtimeConfigRemoteDataSourceProvider.overrideWith(
            (ref) => FakeRuntimeConfigRemoteDataSource(
              (_) async => throw DioException(
                requestOptions: RequestOptions(path: '/runtime-config'),
                type: DioExceptionType.connectionError,
                message: 'Connection failed',
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final errorCompleter = Completer<AsyncValue<TenantRuntimeConfig>>();

      final subscription = container.listen(runtimeConfigProvider, (_, next) {
        if (next.hasError && !errorCompleter.isCompleted) {
          errorCompleter.complete(next);
        }
      }, fireImmediately: true);
      addTearDown(subscription.close);

      final result = await errorCompleter.future.timeout(
        const Duration(seconds: 5),
      );

      expect(result.error, isA<RuntimeConfigLoadException>());
    });
  });
}
