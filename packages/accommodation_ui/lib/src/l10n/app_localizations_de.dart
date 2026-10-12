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
  String get guestProfilePlaceholderTitle => 'Profil (Platzhalter)';

  @override
  String get guestSavedPlaceholderTitle => 'Gespeichert (Platzhalter)';

  @override
  String get guestSavedPlaceholderMessage =>
      'Deine gespeicherten Unterkünfte erscheinen hier.';

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

  @override
  String get guestNavExplore => 'Entdecken';

  @override
  String get guestNavSaved => 'Gespeichert';

  @override
  String get guestNavProfile => 'Profil';

  @override
  String get guestHomeFilters => 'Filter';

  @override
  String get guestHomeAnywhere => 'Überall';

  @override
  String get guestHomeAnyDates => 'Beliebige Daten';

  @override
  String get guestHomeAddGuests => 'Gäste hinzufügen';

  @override
  String get guestHomeAnyPrice => 'Beliebiger Preis';

  @override
  String get guestHomeClearAll => 'Alle löschen';

  @override
  String guestHomeRemoveFilter(String label) {
    return 'Filter $label entfernen';
  }

  @override
  String guestHomeStayCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Unterkünfte',
      one: '1 Unterkunft',
    );
    return '$_temp0';
  }

  @override
  String get guestHomeNoResultsTitle =>
      'Keine Unterkünfte entsprechen deinen Filtern';

  @override
  String get guestHomeNoResultsMessage =>
      'Versuche eine andere Stadt oder erweitere die Preisspanne';

  @override
  String get guestHomeClearFilters => 'Filter zurücksetzen';

  @override
  String get guestHomeEndOfResults => 'Du hast alle Unterkünfte gesehen';

  @override
  String get guestHomeLoadErrorTitle =>
      'Unterkünfte konnten nicht geladen werden';

  @override
  String get guestHomeLoadMoreError =>
      'Weitere Unterkünfte konnten nicht geladen werden.';

  @override
  String get listingsErrorNetwork =>
      'Der Server ist nicht erreichbar. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get listingsErrorGeneric =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String guestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Gäste',
      one: '1 Gast',
    );
    return '$_temp0';
  }

  @override
  String listingUpToGuests(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bis zu $count Gäste',
      one: 'Bis zu 1 Gast',
    );
    return '$_temp0';
  }

  @override
  String get listingPerNight => ' / Nacht';

  @override
  String priceRange(String min, String max) {
    return '$min–$max';
  }

  @override
  String dateRange(String start, String end) {
    return '$start–$end';
  }

  @override
  String get guestFiltersTitle => 'Filter';

  @override
  String get guestFiltersDates => 'Reisedaten';

  @override
  String get guestFiltersCheckIn => 'Anreise';

  @override
  String get guestFiltersCheckOut => 'Abreise';

  @override
  String get guestFiltersAddDate => 'Datum hinzufügen';

  @override
  String get guestFiltersPickDates => 'Wähle An- und Abreise';

  @override
  String guestFiltersNightsHint(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Nächte',
      one: '1 Nacht',
    );
    return '$_temp0 · nur durchgehend freie Unterkünfte werden angezeigt';
  }

  @override
  String get guestFiltersClose => 'Schließen';

  @override
  String get guestFiltersDestination => 'Reiseziel';

  @override
  String get guestFiltersGuests => 'Gäste';

  @override
  String get guestFiltersFewerGuests => 'Weniger Gäste';

  @override
  String get guestFiltersMoreGuests => 'Mehr Gäste';

  @override
  String get guestFiltersPricePerNight => 'Preis pro Nacht';

  @override
  String get guestFiltersShowStays => 'Unterkünfte anzeigen';

  @override
  String guestFiltersShowStayCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Unterkünfte anzeigen',
      one: '1 Unterkunft anzeigen',
    );
    return '$_temp0';
  }

  @override
  String get guestFiltersLoadError =>
      'Die Filteroptionen konnten nicht geladen werden.';

  @override
  String get routeNotFoundTitle => 'Route nicht gefunden';

  @override
  String get routeNotFoundMessage =>
      'Die Route, die du versucht hast zu öffnen, existiert nicht.';

  @override
  String get routeNotFoundAction => 'Zurück zur Startseite';

  @override
  String listingBedrooms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schlafzimmer',
      one: '1 Schlafzimmer',
    );
    return '$_temp0';
  }

  @override
  String listingBeds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count betten',
      one: '1 bett',
    );
    return '$_temp0';
  }

  @override
  String listingBathrooms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Badezimmer',
      one: '1 Badezimmer',
    );
    return '$_temp0';
  }

  @override
  String get cleaningFee => 'Reinigungskosten';

  @override
  String get chipNoRatingText => 'Neu';
}
