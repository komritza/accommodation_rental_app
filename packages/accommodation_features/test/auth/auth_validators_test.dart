import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_features/src/auth/auth_error_mapper.dart';
import 'package:accommodation_features/src/auth/auth_validators.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('validateEmail', () {
    test('rejects empty and malformed values', () {
      expect(validateEmail('', l10n), l10n.authEmailRequired);
      expect(validateEmail('not-an-email', l10n), l10n.authEmailInvalid);
    });

    test('accepts a trimmed email', () {
      expect(validateEmail('  user@example.com  ', l10n), isNull);
    });
  });

  group('validatePassword', () {
    test('rejects short passwords', () {
      expect(validatePassword('', l10n), l10n.authPasswordRequired);
      expect(validatePassword('short', l10n), l10n.authPasswordTooShort);
    });

    test('accepts an 8 character password', () {
      expect(validatePassword('Password', l10n), isNull);
    });
  });

  group('localizedAuthError', () {
    test('maps known failures without exposing internal messages', () {
      expect(
        localizedAuthError(
          l10n,
          const ApiFailure(type: ApiFailureType.network, message: 'Dio error'),
        ),
        l10n.authErrorNetwork,
      );
      expect(
        localizedAuthError(
          l10n,
          const ApiFailure(type: ApiFailureType.http, statusCode: 401),
        ),
        l10n.authErrorBadCredentials,
      );
      expect(
        localizedAuthError(
          l10n,
          const ApiFailure(type: ApiFailureType.http, statusCode: 409),
        ),
        l10n.authErrorUserAlreadyExists,
      );
    });
  });
}
