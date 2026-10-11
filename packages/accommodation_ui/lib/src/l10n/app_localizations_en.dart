// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Accommodation Rental';

  @override
  String get loading => 'Loading configuration...';

  @override
  String get loadError => 'Unable to load the accommodation configuration.';

  @override
  String get retry => 'Retry';

  @override
  String get tenant => 'Tenant';

  @override
  String get currency => 'Currency';

  @override
  String get defaultLanguage => 'Default language';

  @override
  String get availableLanguages => 'Available languages';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get authWelcomeBack => 'Welcome back';

  @override
  String get authSignInSubtitle => 'Sign in to continue.';

  @override
  String get authCreateAccountTitle => 'Create an account';

  @override
  String get authRegisterSubtitle =>
      'Register as a guest to start exploring stays.';

  @override
  String get authFirstName => 'First name';

  @override
  String get authLastName => 'Last name';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authSignIn => 'Sign in';

  @override
  String get authRegister => 'Register';

  @override
  String get authPleaseWait => 'Please wait…';

  @override
  String get authAlreadyHaveAccount => 'Already have an account? ';

  @override
  String get authNewHere => 'New here? ';

  @override
  String get authCreateAnAccount => 'Create an account';

  @override
  String get authFirstNameRequired => 'First name is required';

  @override
  String get authLastNameRequired => 'Last name is required';

  @override
  String get authEmailRequired => 'Email is required';

  @override
  String get authEmailInvalid => 'Enter a valid email';

  @override
  String get authPasswordRequired => 'Password is required';

  @override
  String get authPasswordTooShort => 'Password must be at least 8 characters';

  @override
  String get authErrorBadCredentials => 'Wrong email or password.';

  @override
  String get authErrorUserAlreadyExists => 'That email is already registered.';

  @override
  String get authErrorBadRequest => 'Please check your details and try again.';

  @override
  String get authErrorNetwork =>
      'Unable to reach the server. Check your connection and try again.';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get sessionRestoreErrorTitle => 'Could not restore your session';

  @override
  String get sessionRestoreErrorMessage =>
      'We could not restore your signed-in session. Check your connection and try again.';

  @override
  String get clientHomePlaceholderTitle => 'Client home (placeholder)';

  @override
  String get hostHomePlaceholderTitle => 'Host home (placeholder)';

  @override
  String signedInAs(String name) {
    return 'Signed in as $name';
  }

  @override
  String authenticatedRole(String role) {
    return 'Authenticated role: $role';
  }

  @override
  String get signOut => 'Sign out';
}
