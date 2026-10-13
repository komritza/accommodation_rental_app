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

  @override
  String listingLocation(String city, String country) {
    return '$city, $country';
  }

  @override
  String get listingDetailErrorTitle =>
      'Die Unterkunftsdetails konnten nicht geladen werden';

  @override
  String get listingDetailNotFoundTitle =>
      'Diese Unterkunft ist nicht mehr verfügbar';

  @override
  String get listingDetailNotFoundMessage =>
      'Möglicherweise wurde sie vom Gastgeber entfernt.';

  @override
  String get listingDetailStays => 'Unterkünfte';

  @override
  String listingDetailAppBarTitle(String city, String country) {
    return 'Unterkünfte · $city, $country';
  }

  @override
  String listingDetailPhotoLabel(String title, int index, int count) {
    return '$title, Foto $index von $count';
  }

  @override
  String listingDetailReviews(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Rezensionen',
      one: '1 Rezension',
    );
    return '$_temp0';
  }

  @override
  String get listingDetailAboutThisPlace => 'Über diesen Ort';

  @override
  String get listingDetailWhatThisPlaceOffers => 'Was dieser Ort bietet';

  @override
  String get listingAvailabilityTitle => 'Verfügbarkeit';

  @override
  String get listingAvailabilitySubtitle =>
      'Durchgestrichene Tage sind bereits belegt.';

  @override
  String get listingAvailabilityError =>
      'Die Verfügbarkeit konnte nicht geladen werden.';

  @override
  String get availabilityLegendAvailable => 'Frei';

  @override
  String get availabilityLegendTaken => 'Belegt';

  @override
  String get availabilityLegendToday => 'Heute';

  @override
  String get amenityWifi => 'WLAN';

  @override
  String get amenityKitchen => 'Küche';

  @override
  String get amenityParking => 'Parkplatz';

  @override
  String get amenityWasher => 'Waschmaschine';

  @override
  String get amenityDryer => 'Trockner';

  @override
  String get amenityAirConditioning => 'Klimaanlage';

  @override
  String get amenityHeating => 'Heizung';

  @override
  String get amenityTv => 'Fernseher';

  @override
  String get amenityPool => 'Pool';

  @override
  String get amenityHotTub => 'Whirlpool';

  @override
  String get amenityFireplace => 'Kamin';

  @override
  String get amenityBalcony => 'Balkon';

  @override
  String get amenitySeaView => 'Meerblick';

  @override
  String get amenityMountainView => 'Bergblick';

  @override
  String get amenitySkiStorage => 'Skiaufbewahrung';

  @override
  String get amenityPetsAllowed => 'Haustiere erlaubt';

  @override
  String get amenityWorkspace => 'Arbeitsplatz';

  @override
  String get amenityElevator => 'Aufzug';

  @override
  String get amenityBbq => 'Grill';

  @override
  String get amenitySauna => 'Sauna';

  @override
  String get favouriteAdd => 'Zu Favoriten hinzufügen';

  @override
  String get favouriteRemove => 'Aus Favoriten entfernen';

  @override
  String get favouritesLoadError => 'Favoriten konnten nicht geladen werden';

  @override
  String get favouritesUpdateError =>
      'Favoriten konnten nicht aktualisiert werden';

  @override
  String get favouritesTitle => 'Gespeichert';

  @override
  String get favouritesEmptyTitle => 'Noch keine gespeicherten Unterkünfte';

  @override
  String get favouritesEmptyMessage =>
      'Tippe bei einer Unterkunft auf das Herz, um sie hier zu speichern.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNameFallback => 'Ihr Name';

  @override
  String get hostHomeTitle => 'Meine Unterkünfte';

  @override
  String get hostHomeProfileTooltip => 'Profil öffnen';

  @override
  String get hostHomeLoadErrorTitle =>
      'Deine Unterkünfte konnten nicht geladen werden';

  @override
  String get hostHomeEmptyTitle => 'Noch keine Unterkünfte';

  @override
  String get hostHomeEmptyMessage => 'Deine Unterkünfte werden hier angezeigt.';

  @override
  String hostHomeListingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Unterkünfte',
      one: '1 Unterkunft',
      zero: 'Keine Unterkünfte',
    );
    return '$_temp0';
  }

  @override
  String get hostHomeLoadMoreError =>
      'Weitere Unterkünfte konnten nicht geladen werden.';

  @override
  String get hostHomeEndOfResults => 'Du hast das Ende der Liste erreicht.';

  @override
  String get hostListingDetailTitle => 'Unterkunft verwalten';

  @override
  String get hostListingDetailLoadErrorTitle =>
      'Unterkunft konnte nicht geladen werden';

  @override
  String get hostListingDetailLoadErrorMessage =>
      'Bitte überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get hostListingDetailPropertyInfo => 'Details zur Unterkunft';

  @override
  String get hostListingDetailPropertyType => 'Unterkunftstyp';

  @override
  String get hostListingDetailMaxGuests => 'Maximale Gästezahl';

  @override
  String get hostListingDetailBedrooms => 'Schlafzimmer';

  @override
  String get hostListingDetailBeds => 'Betten';

  @override
  String get hostListingDetailBathrooms => 'Badezimmer';

  @override
  String get hostListingDetailPricing => 'Preise';

  @override
  String get hostListingDetailPricePerNight => 'Preis pro Nacht';

  @override
  String get hostListingDetailCleaningFee => 'Reinigungsgebühr';

  @override
  String get hostListingDetailDescription => 'Beschreibung';

  @override
  String get hostListingDetailEditButton => 'Unterkunft bearbeiten';

  @override
  String get hostEditListingTitle => 'Unterkunft bearbeiten';

  @override
  String get hostEditListingLoadError =>
      'Die Unterkunft konnte nicht geladen werden.';

  @override
  String get hostEditListingGeneralSection => 'Allgemeine Informationen';

  @override
  String get hostEditListingTitleField => 'Titel der Unterkunft';

  @override
  String get hostEditListingDescriptionField => 'Beschreibung';

  @override
  String get hostEditListingPropertyTypeField => 'Unterkunftstyp';

  @override
  String get hostEditListingPricingSection => 'Preise';

  @override
  String get hostEditListingPricePerNightField => 'Preis pro Nacht';

  @override
  String get hostEditListingCleaningFeeField => 'Reinigungsgebühr';

  @override
  String get hostEditListingCapacitySection => 'Kapazität';

  @override
  String get hostEditListingMaxGuestsField => 'Maximale Gästezahl';

  @override
  String get hostEditListingBedroomsField => 'Schlafzimmer';

  @override
  String get hostEditListingBedsField => 'Betten';

  @override
  String get hostEditListingBathroomsField => 'Badezimmer';

  @override
  String get hostEditListingAmenitiesSection => 'Ausstattung';

  @override
  String get hostEditListingSaveButton => 'Änderungen speichern';

  @override
  String get hostEditListingFieldRequired => 'Dieses Feld ist erforderlich.';

  @override
  String get hostEditListingInvalidNumber =>
      'Gib eine gültige Zahl ein, null oder mehr.';

  @override
  String get hostEditListingInvalidWholeNumber =>
      'Gib eine ganze Zahl ein, null oder mehr.';

  @override
  String hostEditListingMinValue(int min) {
    return 'Muss mindestens $min sein.';
  }

  @override
  String get hostEditListingErrorRejected =>
      'Einige Werte wurden nicht akzeptiert. Prüfe das Formular und versuche es erneut.';

  @override
  String get hostEditListingErrorFieldRequired =>
      'Fülle alle Pflichtfelder aus.';

  @override
  String get hostEditListingErrorNotFound =>
      'Dieses Inserat existiert nicht mehr oder gehört nicht dir.';

  @override
  String get hostEditListingErrorGeneric =>
      'Deine Änderungen konnten nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get hostBlockedDaysManageButton => 'Gesperrte Tage verwalten';

  @override
  String get hostBlockedDaysTitle => 'Gesperrte Tage verwalten';

  @override
  String get hostBlockedDaysLoadError =>
      'Kalenderdaten konnten nicht geladen werden. Bitte versuche es erneut.';

  @override
  String get hostBlockedDaysNotAvailable =>
      'Das Verwalten gesperrter Tage ist für diese Unterkunft nicht verfügbar.';

  @override
  String get hostBlockedDaysInstructions =>
      'Wähle ein Datum zum Sperren oder zwei Daten für einen einschließlich gewählten Zeitraum. Tippe auf einen gesperrten Tag, um ihn freizugeben.';

  @override
  String get hostBlockedDaysBlockedLabel => 'Gesperrt';

  @override
  String get hostBlockedDaysBookedLabel => 'Gebucht';

  @override
  String get hostBlockedDaysBlockButton => 'Daten sperren';

  @override
  String get hostBlockedDaysUnblockButton => 'Datum freigeben';

  @override
  String get hostBlockedDaysActionError =>
      'Der Vorgang ist fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get hostBlockedDaysAvailableLabel => 'Verfügbar';

  @override
  String get hostBookingsButton => 'Buchungen ansehen';

  @override
  String get hostBookingsTitle => 'Buchungen';

  @override
  String get hostBookingsLoadErrorTitle =>
      'Buchungen konnten nicht geladen werden';

  @override
  String get hostBookingsEmptyTitle => 'Noch keine Buchungen';

  @override
  String get hostBookingsEmptyMessage =>
      'Buchungen für dieses Inserat erscheinen hier.';

  @override
  String hostBookingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Buchungen',
      one: '1 Buchung',
    );
    return '$_temp0';
  }

  @override
  String hostBookingsNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nächte',
      one: '1 Nacht',
    );
    return '$_temp0';
  }

  @override
  String get hostBookingsLoadMore => 'Mehr laden';

  @override
  String get hostBookingsLoadMoreError =>
      'Weitere Buchungen konnten nicht geladen werden.';

  @override
  String get bookingStatusConfirmed => 'Bestätigt';

  @override
  String get bookingStatusPending => 'Ausstehend';

  @override
  String get bookingStatusCompleted => 'Abgeschlossen';

  @override
  String get bookingStatusCancelled => 'Storniert';

  @override
  String get bookingStatusUnknown => 'Unbekannter Status';
}
