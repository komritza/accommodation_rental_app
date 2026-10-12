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
  String get guestProfilePlaceholderTitle => 'Profile (placeholder)';

  @override
  String get guestSavedPlaceholderTitle => 'Saved (placeholder)';

  @override
  String get guestSavedPlaceholderMessage =>
      'Your saved stays will appear here.';

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
}
