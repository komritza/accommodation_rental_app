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
}
