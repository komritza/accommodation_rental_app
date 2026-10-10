import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../fixtures/tenant_runtime_config_fixture.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late RuntimeConfigRemoteDataSource dataSource;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    dataSource = RuntimeConfigRemoteDataSource(dio);
  });

  group('RuntimeConfigRemoteDataSource', () {
    test('fetches and parses the tenant runtime config', () async {
      adapter.onGet(
        '/tenants/alpine/runtime-config',
        (server) => server.reply(200, validTenantRuntimeConfigJson),
      );

      final config = await dataSource.fetchRuntimeConfig(TenantSlug.alpine);

      expect(config, createTestTenantRuntimeConfig());
      expect(config.slug, TenantSlug.alpine);
    });

    test('throws FormatException when the response body is empty', () async {
      adapter.onGet(
        '/tenants/alpine/runtime-config',
        (server) => server.reply(200, null),
      );

      await expectLater(
        dataSource.fetchRuntimeConfig(TenantSlug.alpine),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
