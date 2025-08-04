import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_az.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('az'),
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @appName.
  ///
  /// In az, this message translates to:
  /// **'DadYolu'**
  String get appName;

  /// No description provided for @welcomeMessage.
  ///
  /// In az, this message translates to:
  /// **'Xoş gəldin, Elmar!'**
  String get welcomeMessage;

  /// No description provided for @todayQuestion.
  ///
  /// In az, this message translates to:
  /// **'Bu gün nə yemək istəyirsən?'**
  String get todayQuestion;

  /// No description provided for @dryFoods.
  ///
  /// In az, this message translates to:
  /// **'Quru yeməklər'**
  String get dryFoods;

  /// No description provided for @liquidFoods.
  ///
  /// In az, this message translates to:
  /// **'Sulu yeməklər'**
  String get liquidFoods;

  /// No description provided for @desserts.
  ///
  /// In az, this message translates to:
  /// **'Şirniyyatlar'**
  String get desserts;

  /// No description provided for @minutesShort.
  ///
  /// In az, this message translates to:
  /// **'dəq'**
  String get minutesShort;

  /// No description provided for @caloriesShort.
  ///
  /// In az, this message translates to:
  /// **'kkal'**
  String get caloriesShort;

  /// No description provided for @hotService.
  ///
  /// In az, this message translates to:
  /// **'İsti'**
  String get hotService;

  /// No description provided for @coldService.
  ///
  /// In az, this message translates to:
  /// **'Soyuq'**
  String get coldService;

  /// No description provided for @vegetarian.
  ///
  /// In az, this message translates to:
  /// **'Vegetarian'**
  String get vegetarian;

  /// No description provided for @description.
  ///
  /// In az, this message translates to:
  /// **'Təsvir'**
  String get description;

  /// No description provided for @ingredients.
  ///
  /// In az, this message translates to:
  /// **'İnqrediyentlər'**
  String get ingredients;

  /// No description provided for @instructions.
  ///
  /// In az, this message translates to:
  /// **'İnstruksiyalar'**
  String get instructions;

  /// No description provided for @specialNotes.
  ///
  /// In az, this message translates to:
  /// **'Xüsusi qeydlər'**
  String get specialNotes;

  /// No description provided for @orderIngredients.
  ///
  /// In az, this message translates to:
  /// **'İnqrediyentləri Sifariş Et'**
  String get orderIngredients;

  /// No description provided for @ingredientOrder.
  ///
  /// In az, this message translates to:
  /// **'İnqrediyent Sifarişi'**
  String get ingredientOrder;

  /// No description provided for @portionCount.
  ///
  /// In az, this message translates to:
  /// **'Porsiya Sayı'**
  String get portionCount;

  /// No description provided for @maxPortions.
  ///
  /// In az, this message translates to:
  /// **'Maksimum 10 porsiya'**
  String get maxPortions;

  /// No description provided for @selectProductsMessage.
  ///
  /// In az, this message translates to:
  /// **'Sifarişinizə əlavə etmək istədiyiniz məhsulları seçin'**
  String get selectProductsMessage;

  /// No description provided for @forRecipe.
  ///
  /// In az, this message translates to:
  /// **'Resept üçün:'**
  String get forRecipe;

  /// No description provided for @maximum.
  ///
  /// In az, this message translates to:
  /// **'Maksimum:'**
  String get maximum;

  /// No description provided for @totalProducts.
  ///
  /// In az, this message translates to:
  /// **'Cəmi məhsul:'**
  String get totalProducts;

  /// No description provided for @confirmOrder.
  ///
  /// In az, this message translates to:
  /// **'Sifarişi Təsdiqlə'**
  String get confirmOrder;

  /// No description provided for @selectProducts.
  ///
  /// In az, this message translates to:
  /// **'Məhsul Seçin'**
  String get selectProducts;

  /// No description provided for @orderConfirmationTitle.
  ///
  /// In az, this message translates to:
  /// **'Sifarişi Təsdiqlə'**
  String get orderConfirmationTitle;

  /// No description provided for @orderSuccessMessage.
  ///
  /// In az, this message translates to:
  /// **'Sifarişiniz uğurla göndərildi! Çatdırılma haqqında məlumat SMS ilə göndəriləcək.'**
  String get orderSuccessMessage;

  /// No description provided for @okay.
  ///
  /// In az, this message translates to:
  /// **'Tamam'**
  String get okay;

  /// No description provided for @azn.
  ///
  /// In az, this message translates to:
  /// **'₼'**
  String get azn;

  /// No description provided for @pieces.
  ///
  /// In az, this message translates to:
  /// **'ədəd'**
  String get pieces;

  /// No description provided for @settings.
  ///
  /// In az, this message translates to:
  /// **'Parametrlər'**
  String get settings;

  /// No description provided for @firstName.
  ///
  /// In az, this message translates to:
  /// **'Adınız'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In az, this message translates to:
  /// **'Soyadınız'**
  String get lastName;

  /// No description provided for @phone.
  ///
  /// In az, this message translates to:
  /// **'Telefon'**
  String get phone;

  /// No description provided for @language.
  ///
  /// In az, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @azerbaijani.
  ///
  /// In az, this message translates to:
  /// **'Azərbaycan'**
  String get azerbaijani;

  /// No description provided for @russian.
  ///
  /// In az, this message translates to:
  /// **'Русский'**
  String get russian;

  /// No description provided for @english.
  ///
  /// In az, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @categoryDryFood.
  ///
  /// In az, this message translates to:
  /// **'quru yemək'**
  String get categoryDryFood;

  /// No description provided for @categoryLiquidFood.
  ///
  /// In az, this message translates to:
  /// **'sulu yemək'**
  String get categoryLiquidFood;

  /// No description provided for @categoryDessert.
  ///
  /// In az, this message translates to:
  /// **'şirniyyat'**
  String get categoryDessert;

  /// No description provided for @hotServiceNote.
  ///
  /// In az, this message translates to:
  /// **'isti servis'**
  String get hotServiceNote;

  /// No description provided for @coldServiceNote.
  ///
  /// In az, this message translates to:
  /// **'soyuq servis'**
  String get coldServiceNote;

  /// No description provided for @vegetarianNote.
  ///
  /// In az, this message translates to:
  /// **'vegetarian'**
  String get vegetarianNote;

  /// No description provided for @userFirstName.
  ///
  /// In az, this message translates to:
  /// **'Elmar'**
  String get userFirstName;

  /// No description provided for @userLastName.
  ///
  /// In az, this message translates to:
  /// **'Salimov'**
  String get userLastName;

  /// No description provided for @userPhoneNumber.
  ///
  /// In az, this message translates to:
  /// **'+994 50 123 45 67'**
  String get userPhoneNumber;

  /// No description provided for @faq.
  ///
  /// In az, this message translates to:
  /// **'Tez-tez verilən suallar'**
  String get faq;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['az', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'az': return AppLocalizationsAz();
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
