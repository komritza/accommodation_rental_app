// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Ferienunterkünfte';

  @override
  String get loading => 'Konfiguration wird geladen...';

  @override
  String get loadError =>
      'Die Unterkunftskonfiguration konnte nicht geladen werden.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get tenant => 'Mandant';

  @override
  String get currency => 'Währung';

  @override
  String get defaultLanguage => 'Standardsprache';

  @override
  String get availableLanguages => 'Verfügbare Sprachen';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get authWelcomeBack => 'Willkommen zurück';

  @override
  String get authSignInSubtitle => 'Melde dich an, um fortzufahren.';

  @override
  String get authCreateAccountTitle => 'Konto erstellen';

  @override
  String get authRegisterSubtitle =>
      'Registriere dich als Gast, um Unterkünfte zu entdecken.';

  @override
  String get authFirstName => 'Vorname';

  @override
  String get authLastName => 'Nachname';

  @override
  String get authEmail => 'E-Mail';

  @override
  String get authPassword => 'Passwort';

  @override
  String get authSignIn => 'Anmelden';

  @override
  String get authRegister => 'Registrieren';

  @override
  String get authPleaseWait => 'Bitte warten…';

  @override
  String get authAlreadyHaveAccount => 'Du hast bereits ein Konto? ';

  @override
  String get authNewHere => 'Neu hier? ';

  @override
  String get authCreateAnAccount => 'Konto erstellen';

  @override
  String get authFirstNameRequired => 'Vorname ist erforderlich';

  @override
  String get authLastNameRequired => 'Nachname ist erforderlich';

  @override
  String get authEmailRequired => 'E-Mail ist erforderlich';

  @override
  String get authEmailInvalid => 'Gib eine gültige E-Mail-Adresse ein';

  @override
  String get authPasswordRequired => 'Passwort ist erforderlich';

  @override
  String get authPasswordTooShort =>
      'Das Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get authErrorBadCredentials =>
      'Falsche E-Mail oder falsches Passwort.';

  @override
  String get authErrorUserAlreadyExists =>
      'Diese E-Mail ist bereits registriert.';

  @override
  String get authErrorBadRequest =>
      'Bitte prüfe deine Angaben und versuche es erneut.';

  @override
  String get authErrorNetwork =>
      'Der Server ist nicht erreichbar. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get authErrorGeneric =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get sessionRestoreErrorTitle =>
      'Sitzung konnte nicht wiederhergestellt werden';

  @override
  String get sessionRestoreErrorMessage =>
      'Wir konnten deine Sitzung nicht wiederherstellen. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get clientHomePlaceholderTitle => 'Kundenstartseite (Platzhalter)';

  @override
  String get hostHomePlaceholderTitle => 'Gastgeberstartseite (Platzhalter)';

  @override
  String signedInAs(String name) {
    return 'Angemeldet als $name';
  }

  @override
  String authenticatedRole(String role) {
    return 'Authentifizierte Rolle: $role';
  }

  @override
  String get signOut => 'Abmelden';
}
