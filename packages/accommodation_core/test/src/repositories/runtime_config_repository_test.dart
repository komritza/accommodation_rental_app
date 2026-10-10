import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/tenant_runtime_config_fixture.dart';

class FakeRuntimeConfigRemoteDataSource extends RuntimeConfigRemoteDataSource {
  FakeRuntimeConfigRemoteDataSource(this._fetch) : super(Dio());

  final Future<TenantRuntimeConfig> Function(TenantSlug tenant) _fetch;

  @override
  Future<TenantRuntimeConfig> fetchRuntimeConfig(TenantSlug tenant) {
    return _fetch(tenant);
  }
}

void main() {
  late FakeRuntimeConfigRemoteDataSource dataSource;
  late RuntimeConfigRepository repository;

  group('RuntimeConfigRepository', () {
    test('returns config when fetching succeeds', () async {
      final config = createTestTenantRuntimeConfig();
      dataSource = FakeRuntimeConfigRemoteDataSource((_) async => config);
      repository = RuntimeConfigRepository(dataSource);

      final result = await repository.fetchRuntimeConfig(TenantSlug.alpine);

      expect(result.isRight(), isTrue);
      expect(result.getRight().toNullable(), config);
    });

    test('maps connection errors to network failures', () async {
      dataSource = FakeRuntimeConfigRemoteDataSource(
        (_) async => throw DioException(
          requestOptions: RequestOptions(path: '/runtime-config'),
          type: DioExceptionType.connectionError,
          message: 'Connection failed',
        ),
      );
      repository = RuntimeConfigRepository(dataSource);

      final result = await repository.fetchRuntimeConfig(TenantSlug.alpine);

      expect(result.isLeft(), isTrue);
      result.match((failure) {
        expect(failure.type, ApiFailureType.network);
        expect(failure.message, 'Connection failed');
      }, (_) => fail('Expected a network failure'));
    });

    test('maps HTTP errors to HTTP failures', () async {
      dataSource = FakeRuntimeConfigRemoteDataSource(
        (_) async => throw DioException(
          requestOptions: RequestOptions(path: '/runtime-config'),
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/runtime-config'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
          message: 'Server error',
        ),
      );
      repository = RuntimeConfigRepository(dataSource);

      final result = await repository.fetchRuntimeConfig(TenantSlug.alpine);

      expect(result.isLeft(), isTrue);
      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 500);
      }, (_) => fail('Expected an HTTP failure'));
    });

    test('maps format exceptions to invalid response failures', () async {
      dataSource = FakeRuntimeConfigRemoteDataSource(
        (_) async => throw const FormatException('Invalid JSON'),
      );
      repository = RuntimeConfigRepository(dataSource);

      final result = await repository.fetchRuntimeConfig(TenantSlug.alpine);

      expect(result.isLeft(), isTrue);
      result.match((failure) {
        expect(failure.type, ApiFailureType.invalidResponse);
        expect(failure.message, 'Invalid JSON');
      }, (_) => fail('Expected an invalid response failure'));
    });
  });
}
