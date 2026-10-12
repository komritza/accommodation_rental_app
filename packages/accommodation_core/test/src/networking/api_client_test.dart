import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late String? storedToken;
  late int tokenReads;
  late Dio dio;
  late Map<String, dynamic> sentHeaders;

  setUp(() {
    storedToken = null;
    tokenReads = 0;
    dio = createApiClient(
      baseUrl: 'https://test.example.com',
      tenant: TenantSlug.alpine,
      readAccessToken: () async {
        tokenReads += 1;
        return storedToken;
      },
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          sentHeaders = Map.of(options.headers);
          handler.next(options);
        },
      ),
    );
    final adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    adapter.onGet('/ping', (server) => server.reply(200, {'ok': true}));
  });

  test('sends the tenant and the stored access token', () async {
    storedToken = 'stored-token';

    await dio.get<void>('/ping');

    expect(sentHeaders['tenant'], 'alpine');
    expect(sentHeaders['Authorization'], 'Bearer stored-token');
  });

  test('omits the authorization header when signed out', () async {
    await dio.get<void>('/ping');

    expect(sentHeaders['tenant'], 'alpine');
    expect(sentHeaders.containsKey('Authorization'), isFalse);
  });

  test('omits the authorization header for an empty token', () async {
    storedToken = '';

    await dio.get<void>('/ping');

    expect(sentHeaders.containsKey('Authorization'), isFalse);
  });

  test('keeps an authorization header set by the request', () async {
    storedToken = 'stored-token';

    await dio.get<void>(
      '/ping',
      options: Options(headers: {'Authorization': 'Bearer explicit-token'}),
    );

    expect(sentHeaders['Authorization'], 'Bearer explicit-token');
    expect(tokenReads, 0);
  });
}
