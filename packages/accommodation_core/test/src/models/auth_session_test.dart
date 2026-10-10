import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthUser', () {
    test('parses the API JSON and maps the role', () {
      final user = AuthUser.fromJson({
        'id': 'host-alpine-1',
        'tenantId': 'alpine',
        'role': 'host',
        'email': 'host@example.com',
        'firstName': 'Anna',
        'lastName': 'Miller',
      });

      expect(user.id, 'host-alpine-1');
      expect(user.tenantId, 'alpine');
      expect(user.role, UserRole.host);
      expect(user.email, 'host@example.com');
      expect(user.firstName, 'Anna');
      expect(user.lastName, 'Miller');
    });

    test('serializes the role using the API value', () {
      final user = AuthUser(
        id: 'client-1',
        tenantId: 'riviera',
        role: UserRole.client,
        email: 'client@example.com',
        firstName: 'Max',
        lastName: 'Smith',
      );

      expect(user.toJson()['role'], 'client');
    });
  });

  group('AuthSession', () {
    test('parses a session including its nested user', () {
      final session = AuthSession.fromJson({
        'accessToken': 'test-access-token',
        'user': {
          'id': 'client-1',
          'tenantId': 'alpine',
          'role': 'client',
          'email': 'client@example.com',
          'firstName': 'Max',
          'lastName': 'Smith',
        },
      });

      expect(session.accessToken, 'test-access-token');
      expect(session.user.id, 'client-1');
      expect(session.user.role, UserRole.client);
    });

    test('serializes the nested user', () {
      final session = AuthSession(
        accessToken: 'test-access-token',
        user: AuthUser(
          id: 'host-1',
          tenantId: 'alpine',
          role: UserRole.host,
          email: 'host@example.com',
          firstName: 'Anna',
          lastName: 'Miller',
        ),
      );

      final json = session.toJson();

      expect(json['accessToken'], 'test-access-token');
      expect(json['user'], isA<Map<String, dynamic>>());
      expect((json['user'] as Map<String, dynamic>)['role'], 'host');
    });
  });
}
