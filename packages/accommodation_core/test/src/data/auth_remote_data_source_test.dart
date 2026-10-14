import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late AuthRemoteDataSource dataSource;

  const accessToken = 'test-access-token';

  Map<String, dynamic> sessionJson(AuthUser user) => {
    'accessToken': accessToken,
    'user': user.toJson(),
  };

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    dataSource = AuthRemoteDataSource(dio);
  });

  group('AuthRemoteDataSource', () {
    group('register', () {
      test('registers a user and parses the auth session', () async {
        adapter.onPost(
          ApiPaths.authRegister,
          (server) => server.reply(201, sessionJson(testClient)),
          queryParameters: {'language': 'en'},
          data: {
            'email': testClient.email,
            'password': 'Password123!',
            'firstName': testClient.firstName,
            'lastName': testClient.lastName,
          },
        );

        final session = await dataSource.register(
          email: testClient.email,
          password: 'Password123!',
          firstName: testClient.firstName,
          lastName: testClient.lastName,
          language: 'en',
        );

        expect(session.accessToken, accessToken);
        expect(session.user, testClient);
      });

      test('throws FormatException when the response body is empty', () async {
        adapter.onPost(
          ApiPaths.authRegister,
          (server) => server.reply(201, null),
          queryParameters: {'language': 'en'},
          data: {
            'email': testClient.email,
            'password': 'Password123!',
            'firstName': testClient.firstName,
            'lastName': testClient.lastName,
          },
        );

        await expectLater(
          dataSource.register(
            email: testClient.email,
            password: 'Password123!',
            firstName: testClient.firstName,
            lastName: testClient.lastName,
            language: 'en',
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('login', () {
      test('logs in and parses the auth session', () async {
        adapter.onPost(
          ApiPaths.authLogin,
          (server) => server.reply(200, sessionJson(testClient)),
          queryParameters: {'language': 'de'},
          data: {'email': testClient.email, 'password': 'Password123!'},
        );

        final session = await dataSource.login(
          email: testClient.email,
          password: 'Password123!',
          language: 'de',
        );

        expect(session.accessToken, accessToken);
        expect(session.user, testClient);
      });

      test('throws FormatException when the response body is empty', () async {
        adapter.onPost(
          ApiPaths.authLogin,
          (server) => server.reply(200, null),
          queryParameters: {'language': 'en'},
          data: {'email': testClient.email, 'password': 'Password123!'},
        );

        await expectLater(
          dataSource.login(
            email: testClient.email,
            password: 'Password123!',
            language: 'en',
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('getCurrentUser', () {
      test('fetches and parses the current user', () async {
        adapter.onGet(
          ApiPaths.authMe,
          (server) => server.reply(200, testHost.toJson()),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        final user = await dataSource.getCurrentUser(accessToken: accessToken);

        expect(user, testHost);
      });

      test('throws FormatException when the response body is empty', () async {
        adapter.onGet(
          ApiPaths.authMe,
          (server) => server.reply(200, null),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        await expectLater(
          dataSource.getCurrentUser(accessToken: accessToken),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('logout', () {
      test('logs out using the access token', () async {
        adapter.onPost(
          ApiPaths.authLogout,
          (server) => server.reply(204, null),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        await expectLater(
          dataSource.logout(accessToken: accessToken),
          completes,
        );
      });
    });
  });
}
