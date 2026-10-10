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
}
