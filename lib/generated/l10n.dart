// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Add Post`
  String get addPost {
    return Intl.message(
      'Add Post',
      name: 'addPost',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 6 characters long`
  String get invalidPassword {
    return Intl.message(
      'Must be at least 6 characters long',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `This Field can't be empty `
  String get isNotEmpty {
    return Intl.message(
      'This Field can\'t be empty ',
      name: 'isNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get passwordHint {
    return Intl.message(
      'Enter Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter Username`
  String get userNameHint {
    return Intl.message(
      'Enter Username',
      name: 'userNameHint',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get close {
    return Intl.message(
      'close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `no Items Found`
  String get noItemsFound {
    return Intl.message(
      'no Items Found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `edit Profile`
  String get editProfile {
    return Intl.message(
      'edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `personal Information`
  String get personalInformation {
    return Intl.message(
      'personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `empty Field Message Error`
  String get emptyFieldMessageError {
    return Intl.message(
      'empty Field Message Error',
      name: 'emptyFieldMessageError',
      desc: '',
      args: [],
    );
  }

  /// `name Contain Text`
  String get nameContainText {
    return Intl.message(
      'name Contain Text',
      name: 'nameContainText',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `login Error`
  String get loginError {
    return Intl.message(
      'login Error',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `we Experienced An Error Logging You In Would You Please`
  String get weExperiencedAnErrorLoggingYouInWouldYouPlease {
    return Intl.message(
      'we Experienced An Error Logging You In Would You Please',
      name: 'weExperiencedAnErrorLoggingYouInWouldYouPlease',
      desc: '',
      args: [],
    );
  }

  /// `noInternetConnection`
  String get noInternetConnection {
    return Intl.message(
      'noInternetConnection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `tryAgain`
  String get tryAgain {
    return Intl.message(
      'tryAgain',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `phoneNumber`
  String get phoneNumber {
    return Intl.message(
      'phoneNumber',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `address`
  String get address {
    return Intl.message(
      'address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `reload`
  String get reload {
    return Intl.message(
      'reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `english`
  String get english {
    return Intl.message(
      'english',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `arabic`
  String get arabic {
    return Intl.message(
      'arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `german`
  String get german {
    return Intl.message(
      'german',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `Add Note`
  String get addNote {
    return Intl.message(
      'Add Note',
      name: 'addNote',
      desc: '',
      args: [],
    );
  }

  /// `Study unit`
  String get studyUnit {
    return Intl.message(
      'Study unit',
      name: 'studyUnit',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To`
  String get welcomeTo {
    return Intl.message(
      'Welcome To',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `LIBCO EXCHANGE`
  String get lIBCOEXCHANGE {
    return Intl.message(
      'LIBCO EXCHANGE',
      name: 'lIBCOEXCHANGE',
      desc: '',
      args: [],
    );
  }

  /// `Create new account`
  String get createNewAccount {
    return Intl.message(
      'Create new account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `login to your account`
  String get loginToYourAccount {
    return Intl.message(
      'login to your account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// ` Create one`
  String get createone {
    return Intl.message(
      ' Create one',
      name: 'createone',
      desc: '',
      args: [],
    );
  }

  /// `please fill your info in order\nto create new account`
  String get pleaseFillYourInfoInOrderToCreateNewAccount {
    return Intl.message(
      'please fill your info in order\nto create new account',
      name: 'pleaseFillYourInfoInOrderToCreateNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Allready have account? `
  String get allreadyHaveAccount {
    return Intl.message(
      'Allready have account? ',
      name: 'allreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `press twice to exit`
  String get pressTwiceToExit {
    return Intl.message(
      'press twice to exit',
      name: 'pressTwiceToExit',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `amount in country`
  String get amountInCountry {
    return Intl.message(
      'amount in country',
      name: 'amountInCountry',
      desc: '',
      args: [],
    );
  }

  /// `amount in jod`
  String get amountInJod {
    return Intl.message(
      'amount in jod',
      name: 'amountInJod',
      desc: '',
      args: [],
    );
  }

  /// `select`
  String get select {
    return Intl.message(
      'select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Promotion code`
  String get promotionCode {
    return Intl.message(
      'Promotion code',
      name: 'promotionCode',
      desc: '',
      args: [],
    );
  }

  /// `Fee type *`
  String get feeType {
    return Intl.message(
      'Fee type *',
      name: 'feeType',
      desc: '',
      args: [],
    );
  }

  /// `Destination country *`
  String get destinationCountry {
    return Intl.message(
      'Destination country *',
      name: 'destinationCountry',
      desc: '',
      args: [],
    );
  }

  /// `Transfer info`
  String get transferInfo {
    return Intl.message(
      'Transfer info',
      name: 'transferInfo',
      desc: '',
      args: [],
    );
  }

  /// `please select the service provider`
  String get pleaseSelectTheServiceProvider {
    return Intl.message(
      'please select the service provider',
      name: 'pleaseSelectTheServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `send money`
  String get sendMoney {
    return Intl.message(
      'send money',
      name: 'sendMoney',
      desc: '',
      args: [],
    );
  }

  /// `Pay in method *`
  String get payInMethod {
    return Intl.message(
      'Pay in method *',
      name: 'payInMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pay out method *`
  String get payOutMethod {
    return Intl.message(
      'Pay out method *',
      name: 'payOutMethod',
      desc: '',
      args: [],
    );
  }

  /// `welcom`
  String get welcom {
    return Intl.message(
      'welcom',
      name: 'welcom',
      desc: '',
      args: [],
    );
  }

  /// `photo library`
  String get photolibrary {
    return Intl.message(
      'photo library',
      name: 'photolibrary',
      desc: '',
      args: [],
    );
  }

  /// `camera`
  String get camera {
    return Intl.message(
      'camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `cropper`
  String get cropper {
    return Intl.message(
      'cropper',
      name: 'cropper',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
