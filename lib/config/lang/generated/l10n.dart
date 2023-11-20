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

class Lang {
  Lang();

  static Lang? _current;

  static Lang get current {
    assert(_current != null,
        'No instance of Lang was loaded. Try to initialize the Lang delegate before accessing Lang.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Lang> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Lang();
      Lang._current = instance;

      return instance;
    });
  }

  static Lang of(BuildContext context) {
    final instance = Lang.maybeOf(context);
    assert(instance != null,
        'No instance of Lang present in the widget tree. Did you add Lang.delegate in localizationsDelegates?');
    return instance!;
  }

  static Lang? maybeOf(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  /// `Wrong email`
  String get validator_email {
    return Intl.message(
      'Wrong email',
      name: 'validator_email',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get validator_required {
    return Intl.message(
      'This field is required',
      name: 'validator_required',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least {length} characters`
  String validator_confirmPasswordLength(int length) {
    return Intl.message(
      'Password must be at least $length characters',
      name: 'validator_confirmPasswordLength',
      desc: '',
      args: [length],
    );
  }

  /// `Passwords do not match`
  String get validator_confirmPassword {
    return Intl.message(
      'Passwords do not match',
      name: 'validator_confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get actions_edit {
    return Intl.message(
      'Edit',
      name: 'actions_edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get actions_delete {
    return Intl.message(
      'Delete',
      name: 'actions_delete',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get actions_ok {
    return Intl.message(
      'Ok',
      name: 'actions_ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get actions_cancel {
    return Intl.message(
      'Cancel',
      name: 'actions_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingScreen_loading {
    return Intl.message(
      'Loading...',
      name: 'loadingScreen_loading',
      desc: '',
      args: [],
    );
  }

  /// `Welcome! glad to see you again!`
  String get loginScreen_welcome {
    return Intl.message(
      'Welcome! glad to see you again!',
      name: 'loginScreen_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginScreen_emailInput {
    return Intl.message(
      'Email',
      name: 'loginScreen_emailInput',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginScreen_passwordInput {
    return Intl.message(
      'Password',
      name: 'loginScreen_passwordInput',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginScreen_buttonText {
    return Intl.message(
      'Login',
      name: 'loginScreen_buttonText',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get loginScreen_alternativesDivider {
    return Intl.message(
      'Or',
      name: 'loginScreen_alternativesDivider',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginScreen_signInWithGoogleButton {
    return Intl.message(
      'Login with Google',
      name: 'loginScreen_signInWithGoogleButton',
      desc: '',
      args: [],
    );
  }

  /// `You do not have an account?`
  String get loginScreen_registerLinkText {
    return Intl.message(
      'You do not have an account?',
      name: 'loginScreen_registerLinkText',
      desc: '',
      args: [],
    );
  }

  /// ` Register`
  String get loginScreen_registerLink {
    return Intl.message(
      ' Register',
      name: 'loginScreen_registerLink',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get loginScreen_forgotYourPasswordLink {
    return Intl.message(
      'Forgot your password?',
      name: 'loginScreen_forgotYourPasswordLink',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerScreen_registerButton {
    return Intl.message(
      'Register',
      name: 'registerScreen_registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Register to get started`
  String get registerScreen_title {
    return Intl.message(
      'Hello! Register to get started',
      name: 'registerScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get registerScreen_nameInput {
    return Intl.message(
      'Name',
      name: 'registerScreen_nameInput',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get registerScreen_emailInput {
    return Intl.message(
      'Email',
      name: 'registerScreen_emailInput',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get registerScreen_passwordInput {
    return Intl.message(
      'Password',
      name: 'registerScreen_passwordInput',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get registerScreen_confrimPasswordInput {
    return Intl.message(
      'Confirm password',
      name: 'registerScreen_confrimPasswordInput',
      desc: '',
      args: [],
    );
  }

  /// `Genres`
  String get genresListScreen_title {
    return Intl.message(
      'Genres',
      name: 'genresListScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Create genre`
  String get genresCreateScreen_title {
    return Intl.message(
      'Create genre',
      name: 'genresCreateScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get genresCreateScreen_nameInput {
    return Intl.message(
      'Name',
      name: 'genresCreateScreen_nameInput',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get genresCreateScreen_createButtonText {
    return Intl.message(
      'Create',
      name: 'genresCreateScreen_createButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Delete genre?`
  String get genresDelete_title {
    return Intl.message(
      'Delete genre?',
      name: 'genresDelete_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete genres?`
  String get genresDelete_titlePlural {
    return Intl.message(
      'Delete genres?',
      name: 'genresDelete_titlePlural',
      desc: '',
      args: [],
    );
  }

  /// `Delete genre`
  String get genresDelete_deleteButton {
    return Intl.message(
      'Delete genre',
      name: 'genresDelete_deleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete {genresCount} genres`
  String genresDelete_deleteButtonPlural(int genresCount) {
    return Intl.message(
      'Delete $genresCount genres',
      name: 'genresDelete_deleteButtonPlural',
      desc: '',
      args: [genresCount],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Lang> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Lang> load(Locale locale) => Lang.load(locale);
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
