import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Accommodation Rental'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading configuration...'**
  String get loading;

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the accommodation configuration.'**
  String get loadError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @tenant.
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @defaultLanguage.
  ///
  /// In en, this message translates to:
  /// **'Default language'**
  String get defaultLanguage;

  /// No description provided for @availableLanguages.
  ///
  /// In en, this message translates to:
  /// **'Available languages'**
  String get availableLanguages;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authWelcomeBack;

  /// No description provided for @authSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue.'**
  String get authSignInSubtitle;

  /// No description provided for @authCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get authCreateAccountTitle;

  /// No description provided for @authRegisterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Register as a guest to start exploring stays.'**
  String get authRegisterSubtitle;

  /// No description provided for @authFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get authFirstName;

  /// No description provided for @authLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get authLastName;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignIn;

  /// No description provided for @authRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegister;

  /// No description provided for @authPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait…'**
  String get authPleaseWait;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authAlreadyHaveAccount;

  /// No description provided for @authNewHere.
  ///
  /// In en, this message translates to:
  /// **'New here? '**
  String get authNewHere;

  /// No description provided for @authCreateAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get authCreateAnAccount;

  /// No description provided for @authFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get authFirstNameRequired;

  /// No description provided for @authLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get authLastNameRequired;

  /// No description provided for @authEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get authEmailRequired;

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get authPasswordRequired;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get authPasswordTooShort;

  /// No description provided for @authErrorBadCredentials.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password.'**
  String get authErrorBadCredentials;

  /// No description provided for @authErrorUserAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'That email is already registered.'**
  String get authErrorUserAlreadyExists;

  /// No description provided for @authErrorBadRequest.
  ///
  /// In en, this message translates to:
  /// **'Please check your details and try again.'**
  String get authErrorBadRequest;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Unable to reach the server. Check your connection and try again.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @sessionRestoreErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not restore your session'**
  String get sessionRestoreErrorTitle;

  /// No description provided for @sessionRestoreErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not restore your signed-in session. Check your connection and try again.'**
  String get sessionRestoreErrorMessage;

  /// No description provided for @guestProfilePlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile (placeholder)'**
  String get guestProfilePlaceholderTitle;

  /// No description provided for @guestSavedPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved (placeholder)'**
  String get guestSavedPlaceholderTitle;

  /// No description provided for @guestSavedPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Your saved stays will appear here.'**
  String get guestSavedPlaceholderMessage;

  /// No description provided for @hostHomePlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Host home (placeholder)'**
  String get hostHomePlaceholderTitle;

  /// No description provided for @signedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {name}'**
  String signedInAs(String name);

  /// No description provided for @authenticatedRole.
  ///
  /// In en, this message translates to:
  /// **'Authenticated role: {role}'**
  String authenticatedRole(String role);

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @guestNavExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get guestNavExplore;

  /// No description provided for @guestNavSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get guestNavSaved;

  /// No description provided for @guestNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get guestNavProfile;

  /// No description provided for @guestHomeFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get guestHomeFilters;

  /// No description provided for @guestHomeAnywhere.
  ///
  /// In en, this message translates to:
  /// **'Anywhere'**
  String get guestHomeAnywhere;

  /// No description provided for @guestHomeAnyDates.
  ///
  /// In en, this message translates to:
  /// **'Any dates'**
  String get guestHomeAnyDates;

  /// No description provided for @guestHomeAddGuests.
  ///
  /// In en, this message translates to:
  /// **'Add guests'**
  String get guestHomeAddGuests;

  /// No description provided for @guestHomeAnyPrice.
  ///
  /// In en, this message translates to:
  /// **'Any price'**
  String get guestHomeAnyPrice;

  /// No description provided for @guestHomeClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get guestHomeClearAll;

  /// No description provided for @guestHomeRemoveFilter.
  ///
  /// In en, this message translates to:
  /// **'Remove filter {label}'**
  String guestHomeRemoveFilter(String label);

  /// No description provided for @guestHomeStayCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 stay} other{{count} stays}}'**
  String guestHomeStayCount(int count);

  /// No description provided for @guestHomeNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No stays match your filters'**
  String get guestHomeNoResultsTitle;

  /// No description provided for @guestHomeNoResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different city or widen the price range'**
  String get guestHomeNoResultsMessage;

  /// No description provided for @guestHomeClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get guestHomeClearFilters;

  /// No description provided for @guestHomeEndOfResults.
  ///
  /// In en, this message translates to:
  /// **'You\'ve seen all stays'**
  String get guestHomeEndOfResults;

  /// No description provided for @guestHomeLoadErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load stays'**
  String get guestHomeLoadErrorTitle;

  /// No description provided for @guestHomeLoadMoreError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load more stays.'**
  String get guestHomeLoadMoreError;

  /// No description provided for @listingsErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Unable to reach the server. Check your connection and try again.'**
  String get listingsErrorNetwork;

  /// No description provided for @listingsErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get listingsErrorGeneric;

  /// No description provided for @guestCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 guest} other{{count} guests}}'**
  String guestCount(int count);

  /// No description provided for @listingUpToGuests.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Up to 1 guest} other{Up to {count} guests}}'**
  String listingUpToGuests(int count);

  /// No description provided for @listingPerNight.
  ///
  /// In en, this message translates to:
  /// **' / night'**
  String get listingPerNight;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max}'**
  String priceRange(String min, String max);

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'{start}–{end}'**
  String dateRange(String start, String end);

  /// No description provided for @guestFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get guestFiltersTitle;

  /// No description provided for @guestFiltersDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get guestFiltersDates;

  /// No description provided for @guestFiltersCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get guestFiltersCheckIn;

  /// No description provided for @guestFiltersCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get guestFiltersCheckOut;

  /// No description provided for @guestFiltersAddDate.
  ///
  /// In en, this message translates to:
  /// **'Add date'**
  String get guestFiltersAddDate;

  /// No description provided for @guestFiltersPickDates.
  ///
  /// In en, this message translates to:
  /// **'Pick check-in and check-out'**
  String get guestFiltersPickDates;

  /// No description provided for @guestFiltersNightsHint.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 night} other{{count} nights}} · only stays free for the whole range are shown'**
  String guestFiltersNightsHint(int count);

  /// No description provided for @guestFiltersClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get guestFiltersClose;

  /// No description provided for @guestFiltersDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get guestFiltersDestination;

  /// No description provided for @guestFiltersGuests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get guestFiltersGuests;

  /// No description provided for @guestFiltersFewerGuests.
  ///
  /// In en, this message translates to:
  /// **'Fewer guests'**
  String get guestFiltersFewerGuests;

  /// No description provided for @guestFiltersMoreGuests.
  ///
  /// In en, this message translates to:
  /// **'More guests'**
  String get guestFiltersMoreGuests;

  /// No description provided for @guestFiltersPricePerNight.
  ///
  /// In en, this message translates to:
  /// **'Price per night'**
  String get guestFiltersPricePerNight;

  /// No description provided for @guestFiltersShowStays.
  ///
  /// In en, this message translates to:
  /// **'Show stays'**
  String get guestFiltersShowStays;

  /// No description provided for @guestFiltersShowStayCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Show 1 stay} other{Show {count} stays}}'**
  String guestFiltersShowStayCount(int count);

  /// No description provided for @guestFiltersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the filter options.'**
  String get guestFiltersLoadError;

  /// No description provided for @routeNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Route not found'**
  String get routeNotFoundTitle;

  /// No description provided for @routeNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The route you tried to open doesn\'t exist.'**
  String get routeNotFoundMessage;

  /// No description provided for @routeNotFoundAction.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get routeNotFoundAction;

  /// No description provided for @listingBedrooms.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 bedroom} other{{count} bedrooms}}'**
  String listingBedrooms(int count);

  /// No description provided for @listingBeds.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 bed} other{{count} beds}}'**
  String listingBeds(int count);

  /// No description provided for @listingBathrooms.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 bathroom} other{{count} bathrooms}}'**
  String listingBathrooms(int count);

  /// No description provided for @cleaningFee.
  ///
  /// In en, this message translates to:
  /// **'Cleaning fee'**
  String get cleaningFee;

  /// No description provided for @chipNoRatingText.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get chipNoRatingText;

  /// No description provided for @listingLocation.
  ///
  /// In en, this message translates to:
  /// **'{city}, {country}'**
  String listingLocation(String city, String country);

  /// No description provided for @listingDetailErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load listing details'**
  String get listingDetailErrorTitle;

  /// No description provided for @listingDetailNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'This stay is no longer available'**
  String get listingDetailNotFoundTitle;

  /// No description provided for @listingDetailNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'It may have been removed by the host.'**
  String get listingDetailNotFoundMessage;

  /// No description provided for @listingDetailStays.
  ///
  /// In en, this message translates to:
  /// **'Stays'**
  String get listingDetailStays;

  /// No description provided for @listingDetailAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Stays · {city}, {country}'**
  String listingDetailAppBarTitle(String city, String country);

  /// No description provided for @listingDetailPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'{title}, photo {index} of {count}'**
  String listingDetailPhotoLabel(String title, int index, int count);

  /// No description provided for @listingDetailReviews.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 review} other{{count} reviews}}'**
  String listingDetailReviews(int count);

  /// No description provided for @listingDetailAboutThisPlace.
  ///
  /// In en, this message translates to:
  /// **'About this place'**
  String get listingDetailAboutThisPlace;

  /// No description provided for @listingDetailWhatThisPlaceOffers.
  ///
  /// In en, this message translates to:
  /// **'What this place offers'**
  String get listingDetailWhatThisPlaceOffers;

  /// No description provided for @listingAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get listingAvailabilityTitle;

  /// No description provided for @listingAvailabilitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Struck-through days are already taken.'**
  String get listingAvailabilitySubtitle;

  /// No description provided for @listingAvailabilityError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load availability.'**
  String get listingAvailabilityError;

  /// No description provided for @availabilityLegendAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get availabilityLegendAvailable;

  /// No description provided for @availabilityLegendTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get availabilityLegendTaken;

  /// No description provided for @availabilityLegendToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get availabilityLegendToday;

  /// No description provided for @amenityWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get amenityWifi;

  /// No description provided for @amenityKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get amenityKitchen;

  /// No description provided for @amenityParking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get amenityParking;

  /// No description provided for @amenityWasher.
  ///
  /// In en, this message translates to:
  /// **'Washing machine'**
  String get amenityWasher;

  /// No description provided for @amenityDryer.
  ///
  /// In en, this message translates to:
  /// **'Dryer'**
  String get amenityDryer;

  /// No description provided for @amenityAirConditioning.
  ///
  /// In en, this message translates to:
  /// **'Air conditioning'**
  String get amenityAirConditioning;

  /// No description provided for @amenityHeating.
  ///
  /// In en, this message translates to:
  /// **'Heating'**
  String get amenityHeating;

  /// No description provided for @amenityTv.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get amenityTv;

  /// No description provided for @amenityPool.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get amenityPool;

  /// No description provided for @amenityHotTub.
  ///
  /// In en, this message translates to:
  /// **'Hot tub'**
  String get amenityHotTub;

  /// No description provided for @amenityFireplace.
  ///
  /// In en, this message translates to:
  /// **'Fireplace'**
  String get amenityFireplace;

  /// No description provided for @amenityBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get amenityBalcony;

  /// No description provided for @amenitySeaView.
  ///
  /// In en, this message translates to:
  /// **'Sea view'**
  String get amenitySeaView;

  /// No description provided for @amenityMountainView.
  ///
  /// In en, this message translates to:
  /// **'Mountain view'**
  String get amenityMountainView;

  /// No description provided for @amenitySkiStorage.
  ///
  /// In en, this message translates to:
  /// **'Ski storage'**
  String get amenitySkiStorage;

  /// No description provided for @amenityPetsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Pets allowed'**
  String get amenityPetsAllowed;

  /// No description provided for @amenityWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Workspace'**
  String get amenityWorkspace;

  /// No description provided for @amenityElevator.
  ///
  /// In en, this message translates to:
  /// **'Elevator'**
  String get amenityElevator;

  /// No description provided for @amenityBbq.
  ///
  /// In en, this message translates to:
  /// **'BBQ'**
  String get amenityBbq;

  /// No description provided for @amenitySauna.
  ///
  /// In en, this message translates to:
  /// **'Sauna'**
  String get amenitySauna;

  /// No description provided for @favouriteAdd.
  ///
  /// In en, this message translates to:
  /// **'Save to favourites'**
  String get favouriteAdd;

  /// No description provided for @favouriteRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get favouriteRemove;

  /// No description provided for @favouritesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load favourites'**
  String get favouritesLoadError;

  /// No description provided for @favouritesUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Unable to update favourites'**
  String get favouritesUpdateError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
