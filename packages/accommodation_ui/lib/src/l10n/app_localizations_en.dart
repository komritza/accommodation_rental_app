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
  String get signOut => 'Sign out';

  @override
  String get guestNavExplore => 'Explore';

  @override
  String get guestNavSaved => 'Saved';

  @override
  String get guestNavProfile => 'Profile';

  @override
  String get guestHomeFilters => 'Filters';

  @override
  String get guestHomeAnywhere => 'Anywhere';

  @override
  String get guestHomeAnyDates => 'Any dates';

  @override
  String get guestHomeAddGuests => 'Add guests';

  @override
  String get guestHomeAnyPrice => 'Any price';

  @override
  String get guestHomeClearAll => 'Clear all';

  @override
  String guestHomeRemoveFilter(String label) {
    return 'Remove filter $label';
  }

  @override
  String guestHomeStayCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString stays',
      one: '1 stay',
    );
    return '$_temp0';
  }

  @override
  String get guestHomeNoResultsTitle => 'No stays match your filters';

  @override
  String get guestHomeNoResultsMessage =>
      'Try a different city or widen the price range';

  @override
  String get guestHomeClearFilters => 'Clear filters';

  @override
  String get guestHomeEndOfResults => 'You\'ve seen all stays';

  @override
  String get guestHomeLoadErrorTitle => 'Couldn\'t load stays';

  @override
  String get guestHomeLoadMoreError => 'Couldn\'t load more stays.';

  @override
  String get listingsErrorNetwork =>
      'Unable to reach the server. Check your connection and try again.';

  @override
  String get listingsErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String guestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count guests',
      one: '1 guest',
    );
    return '$_temp0';
  }

  @override
  String listingUpToGuests(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Up to $count guests',
      one: 'Up to 1 guest',
    );
    return '$_temp0';
  }

  @override
  String get listingPerNight => ' / night';

  @override
  String priceRange(String min, String max) {
    return '$min–$max';
  }

  @override
  String dateRange(String start, String end) {
    return '$start–$end';
  }

  @override
  String get guestFiltersTitle => 'Filters';

  @override
  String get guestFiltersDates => 'Dates';

  @override
  String get guestFiltersCheckIn => 'Check-in';

  @override
  String get guestFiltersCheckOut => 'Check-out';

  @override
  String get guestFiltersAddDate => 'Add date';

  @override
  String get guestFiltersPickDates => 'Pick check-in and check-out';

  @override
  String guestFiltersNightsHint(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString nights',
      one: '1 night',
    );
    return '$_temp0 · only stays free for the whole range are shown';
  }

  @override
  String get guestFiltersClose => 'Close';

  @override
  String get guestFiltersDestination => 'Destination';

  @override
  String get guestFiltersGuests => 'Guests';

  @override
  String get guestFiltersFewerGuests => 'Fewer guests';

  @override
  String get guestFiltersMoreGuests => 'More guests';

  @override
  String get guestFiltersPricePerNight => 'Price per night';

  @override
  String get guestFiltersShowStays => 'Show stays';

  @override
  String guestFiltersShowStayCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Show $countString stays',
      one: 'Show 1 stay',
    );
    return '$_temp0';
  }

  @override
  String get guestFiltersLoadError => 'Couldn\'t load the filter options.';

  @override
  String get routeNotFoundTitle => 'Route not found';

  @override
  String get routeNotFoundMessage =>
      'The route you tried to open doesn\'t exist.';

  @override
  String get routeNotFoundAction => 'Back to home';

  @override
  String listingBedrooms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bedrooms',
      one: '1 bedroom',
    );
    return '$_temp0';
  }

  @override
  String listingBeds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beds',
      one: '1 bed',
    );
    return '$_temp0';
  }

  @override
  String listingBathrooms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bathrooms',
      one: '1 bathroom',
    );
    return '$_temp0';
  }

  @override
  String get cleaningFee => 'Cleaning fee';

  @override
  String get chipNoRatingText => 'New';

  @override
  String listingLocation(String city, String country) {
    return '$city, $country';
  }

  @override
  String get listingDetailErrorTitle => 'Couldn\'t load listing details';

  @override
  String get listingDetailNotFoundTitle => 'This stay is no longer available';

  @override
  String get listingDetailNotFoundMessage =>
      'It may have been removed by the host.';

  @override
  String get listingDetailStays => 'Stays';

  @override
  String listingDetailAppBarTitle(String city, String country) {
    return 'Stays · $city, $country';
  }

  @override
  String listingDetailPhotoLabel(String title, int index, int count) {
    return '$title, photo $index of $count';
  }

  @override
  String listingDetailReviews(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
    );
    return '$_temp0';
  }

  @override
  String get listingDetailAboutThisPlace => 'About this place';

  @override
  String get listingDetailWhatThisPlaceOffers => 'What this place offers';

  @override
  String get listingAvailabilityTitle => 'Availability';

  @override
  String get listingAvailabilitySubtitle =>
      'Struck-through days are already taken.';

  @override
  String get listingAvailabilityError => 'Couldn\'t load availability.';

  @override
  String get availabilityLegendAvailable => 'Available';

  @override
  String get availabilityLegendTaken => 'Taken';

  @override
  String get availabilityLegendToday => 'Today';

  @override
  String get amenityWifi => 'Wi-Fi';

  @override
  String get amenityKitchen => 'Kitchen';

  @override
  String get amenityParking => 'Parking';

  @override
  String get amenityWasher => 'Washing machine';

  @override
  String get amenityDryer => 'Dryer';

  @override
  String get amenityAirConditioning => 'Air conditioning';

  @override
  String get amenityHeating => 'Heating';

  @override
  String get amenityTv => 'TV';

  @override
  String get amenityPool => 'Pool';

  @override
  String get amenityHotTub => 'Hot tub';

  @override
  String get amenityFireplace => 'Fireplace';

  @override
  String get amenityBalcony => 'Balcony';

  @override
  String get amenitySeaView => 'Sea view';

  @override
  String get amenityMountainView => 'Mountain view';

  @override
  String get amenitySkiStorage => 'Ski storage';

  @override
  String get amenityPetsAllowed => 'Pets allowed';

  @override
  String get amenityWorkspace => 'Workspace';

  @override
  String get amenityElevator => 'Elevator';

  @override
  String get amenityBbq => 'BBQ';

  @override
  String get amenitySauna => 'Sauna';

  @override
  String get favouriteAdd => 'Save to favourites';

  @override
  String get favouriteRemove => 'Remove from favourites';

  @override
  String get favouritesLoadError => 'Unable to load favourites';

  @override
  String get favouritesUpdateError => 'Unable to update favourites';

  @override
  String get favouritesTitle => 'Saved';

  @override
  String get favouritesEmptyTitle => 'No saved stays yet';

  @override
  String get favouritesEmptyMessage =>
      'Tap the heart on a stay to save it here.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileNameFallback => 'Your name';

  @override
  String get hostHomeTitle => 'My listings';

  @override
  String get hostHomeProfileTooltip => 'Open profile';

  @override
  String get hostHomeLoadErrorTitle => 'Couldn\'t load your listings';

  @override
  String get hostHomeEmptyTitle => 'No listings yet';

  @override
  String get hostHomeEmptyMessage => 'Your listings will appear here.';

  @override
  String hostHomeListingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count listings',
      one: '1 listing',
      zero: 'No listings',
    );
    return '$_temp0';
  }

  @override
  String get hostHomeLoadMoreError => 'Couldn\'t load more listings.';

  @override
  String get hostHomeEndOfResults => 'You\'ve reached the end.';

  @override
  String get hostListingDetailTitle => 'Manage listing';

  @override
  String get hostListingDetailLoadErrorTitle => 'Couldn\'t load listing';

  @override
  String get hostListingDetailLoadErrorMessage =>
      'Please check your connection and try again.';

  @override
  String get hostListingDetailPropertyInfo => 'Property details';

  @override
  String get hostListingDetailPropertyType => 'Property type';

  @override
  String get hostListingDetailMaxGuests => 'Maximum guests';

  @override
  String get hostListingDetailBedrooms => 'Bedrooms';

  @override
  String get hostListingDetailBeds => 'Beds';

  @override
  String get hostListingDetailBathrooms => 'Bathrooms';

  @override
  String get hostListingDetailPricing => 'Pricing';

  @override
  String get hostListingDetailPricePerNight => 'Price per night';

  @override
  String get hostListingDetailCleaningFee => 'Cleaning fee';

  @override
  String get hostListingDetailDescription => 'Description';

  @override
  String get hostListingDetailEditButton => 'Edit listing';

  @override
  String get hostEditListingTitle => 'Edit listing';

  @override
  String get hostEditListingLoadError => 'Couldn\'t load listing.';

  @override
  String get hostEditListingGeneralSection => 'General information';

  @override
  String get hostEditListingTitleField => 'Listing title';

  @override
  String get hostEditListingDescriptionField => 'Description';

  @override
  String get hostEditListingPropertyTypeField => 'Property type';

  @override
  String get hostEditListingPricingSection => 'Pricing';

  @override
  String get hostEditListingPricePerNightField => 'Price per night';

  @override
  String get hostEditListingCleaningFeeField => 'Cleaning fee';

  @override
  String get hostEditListingCapacitySection => 'Capacity';

  @override
  String get hostEditListingMaxGuestsField => 'Maximum guests';

  @override
  String get hostEditListingBedroomsField => 'Bedrooms';

  @override
  String get hostEditListingBedsField => 'Beds';

  @override
  String get hostEditListingBathroomsField => 'Bathrooms';

  @override
  String get hostEditListingAmenitiesSection => 'Amenities';

  @override
  String get hostEditListingSaveButton => 'Save changes';

  @override
  String get hostEditListingFieldRequired => 'This field is required.';

  @override
  String get hostEditListingInvalidNumber =>
      'Enter a valid number, zero or more.';

  @override
  String get hostEditListingInvalidWholeNumber =>
      'Enter a whole number, zero or more.';

  @override
  String hostEditListingMinValue(int min) {
    return 'Must be at least $min.';
  }

  @override
  String get hostEditListingErrorRejected =>
      'Some values weren\'t accepted. Check the form and try again.';

  @override
  String get hostEditListingErrorFieldRequired =>
      'Fill in every required field.';

  @override
  String get hostEditListingErrorNotFound =>
      'This listing no longer exists or isn\'t yours.';

  @override
  String get hostEditListingErrorGeneric =>
      'Couldn\'t save your changes. Please try again.';

  @override
  String get hostBlockedDaysManageButton => 'Manage blocked dates';

  @override
  String get hostBlockedDaysTitle => 'Manage blocked dates';

  @override
  String get hostBlockedDaysLoadError =>
      'Couldn\'t load calendar data. Please try again.';

  @override
  String get hostBlockedDaysNotAvailable =>
      'Managing blocked dates isn\'t available for this property.';

  @override
  String get hostBlockedDaysInstructions =>
      'Select a date to block it, or select two dates to block the inclusive range. Tap a blocked date to unblock it.';

  @override
  String get hostBlockedDaysBlockedLabel => 'Blocked';

  @override
  String get hostBlockedDaysBookedLabel => 'Booked';

  @override
  String get hostBlockedDaysBlockButton => 'Block dates';

  @override
  String get hostBlockedDaysUnblockButton => 'Unblock date';

  @override
  String get hostBlockedDaysActionError =>
      'The operation failed. Please try again.';

  @override
  String get hostBlockedDaysAvailableLabel => 'Available';
}
