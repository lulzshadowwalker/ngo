import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Sign Up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sigup;

  /// Text for connecting and evaluating volunteers
  ///
  /// In en, this message translates to:
  /// **'Connect. Evaluate. Volunteers.'**
  String get connent_evaluate_volunteer;

  /// Call to action for joining the volunteering community
  ///
  /// In en, this message translates to:
  /// **'Join Jordan\'s largest volunteering community'**
  String get join_us;

  /// Button text for continuing as a guest user
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continue_as_guest;

  /// Text for joining the community
  ///
  /// In en, this message translates to:
  /// **'Join Our Community'**
  String get join_our_community;

  /// Text indicating the type of user joining
  ///
  /// In en, this message translates to:
  /// **'I am joining as an'**
  String get iam_joining_as;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// Description for individual users
  ///
  /// In en, this message translates to:
  /// **'For personal use and volunteering'**
  String get for_personal_use_and_volunteering;

  /// Text for organizations or NGOs
  ///
  /// In en, this message translates to:
  /// **'Organization (NGO)'**
  String get organization;

  /// Description for organizations or NGOs
  ///
  /// In en, this message translates to:
  /// **'For registered non-profie organizations'**
  String get for_registered_organizations;

  /// Text indicating agreement to terms and conditions
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our'**
  String get by_continuing_you_agree_to;

  /// Link text for terms and conditions
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_and_conditions;

  /// Conjunction used in legal agreements
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// Link text for privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'NGO 962'**
  String get app_name;

  /// Application tagline
  ///
  /// In en, this message translates to:
  /// **'Connect. Evaluate. Volunteer.'**
  String get connect_evaluate_volunteer;

  /// Profile completion prompt
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get complete_your_profile;

  /// Progress indicator
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3'**
  String get step_1_of_3;

  /// Following status or tab
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// Recently tab
  ///
  /// In en, this message translates to:
  /// **'Recently'**
  String get recently;

  /// Follow button
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Profile screen title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Home screen title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Organizations screen title
  ///
  /// In en, this message translates to:
  /// **'Organizations'**
  String get organizations;

  /// Opportunities screen title
  ///
  /// In en, this message translates to:
  /// **'Opportunities'**
  String get opportunities;

  /// Blog screen title
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// Search functionality
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Notifications screen title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Phone field label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Address field label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// Success message for login
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get login_successful;

  /// Error message for login
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get login_failed;

  /// Error message for registration
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registration_failed;

  /// Error message for logout
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logout_failed;

  /// General error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error_occurred;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get are_you_sure_logout;

  /// Logout progress message
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get logging_out;

  /// Search field hint
  ///
  /// In en, this message translates to:
  /// **'Search NGOs, programs, opportunities.'**
  String get search_ngos_programs;

  /// Search results title
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get search_results;

  /// My applications tab
  ///
  /// In en, this message translates to:
  /// **'My Applications'**
  String get my_applications;

  /// My evaluations tab
  ///
  /// In en, this message translates to:
  /// **'My Evaluations'**
  String get my_evaluations;

  /// Edit profile option
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// Change password option
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// Deactivate account option
  ///
  /// In en, this message translates to:
  /// **'Deactivate Account'**
  String get deactivate_account;

  /// Push notifications setting
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get push_notifications;

  /// Email notifications setting
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get email_notifications;

  /// Profile visibility setting
  ///
  /// In en, this message translates to:
  /// **'Profile Visibility'**
  String get profile_visibility;

  /// Data management setting
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get data_management;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Appearance setting
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Help center option
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// Report problem option
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get report_problem;

  /// About app option
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get about_app;

  /// Privacy section title
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// General section title
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Account section title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @forgot_fassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_fassword;

  /// No description provided for @dont_have_an.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_an;

  /// Following NGOs section title
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following_ng;

  /// Recently tab title
  ///
  /// In en, this message translates to:
  /// **'Recently'**
  String get recentlyNg;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
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
