import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late AuthRemoteDataSource dataSource;
  late AuthRepository repository;

  const userJson = {
    'id': 'client-1',
    'tenantId': 'alpine',
    'role': 'client',
    'email': 'client@example.com',
    'firstName': 'Alex',
    'lastName': 'Smith',
  };

  const sessionJson = {'accessToken': 'test-token', 'user': userJson};

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;

    dataSource = AuthRemoteDataSource(dio);
    repository = AuthRepository(dataSource);
  });

  group('login', () {
    test('sends credentials and language and parses the session', () async {
      adapter.onPost(
        '/auth/login',
        (server) => server.reply(200, sessionJson),
        queryParameters: {'language': 'de'},
        data: {'email': 'client@example.com', 'password': 'password123'},
      );

      final result = await repository.login(
        email: 'client@example.com',
        password: 'password123',
        language: 'de',
      );

      expect(result.isRight(), isTrue);
      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        session,
      ) {
        expect(session.accessToken, 'test-token');
        expect(session.user.role, UserRole.client);
      });
    });

    test('maps invalid credentials to an HTTP failure', () async {
      adapter.onPost(
        '/auth/login',
        (server) => server.reply(401, {'message': 'Invalid credentials'}),
        queryParameters: {'language': 'en'},
        data: {'email': 'client@example.com', 'password': 'wrong-password'},
      );

      final result = await repository.login(
        email: 'client@example.com',
        password: 'wrong-password',
        language: 'en',
      );

      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 401);
      }, (_) => fail('Expected an HTTP failure'));
    });
  });

  group('register', () {
    test('sends registration fields and parses the session', () async {
      adapter.onPost(
        '/auth/register',
        (server) => server.reply(201, sessionJson),
        queryParameters: {'language': 'en'},
        data: {
          'email': 'client@example.com',
          'password': 'password123',
          'firstName': 'Alex',
          'lastName': 'Smith',
        },
      );

      final result = await repository.register(
        email: 'client@example.com',
        password: 'password123',
        firstName: 'Alex',
        lastName: 'Smith',
        language: 'en',
      );

      expect(result.isRight(), isTrue);
      result.match(
        (failure) => fail('Unexpected failure: ${failure.type}'),
        (session) => expect(session.user.id, 'client-1'),
      );
    });
  });

  group('getCurrentUser', () {
    test('sends the bearer token and parses the user', () async {
      adapter.onGet(
        '/auth/me',
        (server) => server.reply(200, userJson),
        headers: {'Authorization': 'Bearer test-token'},
      );

      final result = await repository.getCurrentUser(accessToken: 'test-token');

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        user,
      ) {
        expect(user.id, 'client-1');
        expect(user.role, UserRole.client);
      });
    });
  });

  group('logout', () {
    test('accepts a 204 response', () async {
      adapter.onPost(
        '/auth/logout',
        (server) => server.reply(204, null),
        headers: {'Authorization': 'Bearer test-token'},
      );

      final result = await repository.logout(accessToken: 'test-token');

      result.match(
        (failure) => fail('Unexpected failure: ${failure.type}'),
        (success) => expect(success, isTrue),
      );
    });

    test('maps a revoked token response to an HTTP failure', () async {
      adapter.onPost(
        '/auth/logout',
        (server) => server.reply(401, {'message': 'Unauthorized'}),
        headers: {'Authorization': 'Bearer test-token'},
      );

      final result = await repository.logout(accessToken: 'test-token');

      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 401);
      }, (_) => fail('Expected an HTTP failure'));
    });
  });
}
