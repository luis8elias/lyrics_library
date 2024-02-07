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

  /// `Favorites`
  String get app_favorites {
    return Intl.message(
      'Favorites',
      name: 'app_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Songs`
  String get app_songs {
    return Intl.message(
      'Songs',
      name: 'app_songs',
      desc: '',
      args: [],
    );
  }

  /// `Setlists`
  String get app_setlists {
    return Intl.message(
      'Setlists',
      name: 'app_setlists',
      desc: '',
      args: [],
    );
  }

  /// `Genres`
  String get app_genres {
    return Intl.message(
      'Genres',
      name: 'app_genres',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get app_more {
    return Intl.message(
      'More',
      name: 'app_more',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get app_items {
    return Intl.message(
      'Items',
      name: 'app_items',
      desc: '',
      args: [],
    );
  }

  /// `Selected items`
  String get app_selectedItems {
    return Intl.message(
      'Selected items',
      name: 'app_selectedItems',
      desc: '',
      args: [],
    );
  }

  /// `Setlist`
  String get app_setlist {
    return Intl.message(
      'Setlist',
      name: 'app_setlist',
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

  /// `Remove`
  String get actions_remove {
    return Intl.message(
      'Remove',
      name: 'actions_remove',
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

  /// `Back`
  String get actions_back {
    return Intl.message(
      'Back',
      name: 'actions_back',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get actions_save {
    return Intl.message(
      'Save',
      name: 'actions_save',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get actions_search {
    return Intl.message(
      'Search',
      name: 'actions_search',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get actions_next {
    return Intl.message(
      'Next',
      name: 'actions_next',
      desc: '',
      args: [],
    );
  }

  /// `Prev`
  String get actions_prev {
    return Intl.message(
      'Prev',
      name: 'actions_prev',
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

  /// `Create Genre`
  String get genresCreateScreen_title {
    return Intl.message(
      'Create Genre',
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

  /// `Edit Genre`
  String get genresEditScreen_title {
    return Intl.message(
      'Edit Genre',
      name: 'genresEditScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get genresEditScreen_nameInput {
    return Intl.message(
      'Name',
      name: 'genresEditScreen_nameInput',
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

  /// `Songs`
  String get songsListScreen_title {
    return Intl.message(
      'Songs',
      name: 'songsListScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Create Song`
  String get songsCreateScreen_title {
    return Intl.message(
      'Create Song',
      name: 'songsCreateScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get songsCreateScreen_titleInput {
    return Intl.message(
      'Title',
      name: 'songsCreateScreen_titleInput',
      desc: '',
      args: [],
    );
  }

  /// `Write the lyrics of the song`
  String get songsCreateScreen_lyricInput {
    return Intl.message(
      'Write the lyrics of the song',
      name: 'songsCreateScreen_lyricInput',
      desc: '',
      args: [],
    );
  }

  /// `Delete song?`
  String get songsDelete_title {
    return Intl.message(
      'Delete song?',
      name: 'songsDelete_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete songs?`
  String get songsDelete_titlePlural {
    return Intl.message(
      'Delete songs?',
      name: 'songsDelete_titlePlural',
      desc: '',
      args: [],
    );
  }

  /// `Delete song`
  String get songsDelete_deleteButton {
    return Intl.message(
      'Delete song',
      name: 'songsDelete_deleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete {songsCount} songs`
  String songsDelete_deleteButtonPlural(int songsCount) {
    return Intl.message(
      'Delete $songsCount songs',
      name: 'songsDelete_deleteButtonPlural',
      desc: '',
      args: [songsCount],
    );
  }

  /// `Edit Song`
  String get songsEditScreen_title {
    return Intl.message(
      'Edit Song',
      name: 'songsEditScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get songsEditScreen_titleInput {
    return Intl.message(
      'Title',
      name: 'songsEditScreen_titleInput',
      desc: '',
      args: [],
    );
  }

  /// `Write the lyrics of the song`
  String get songsEditScreen_lyricInput {
    return Intl.message(
      'Write the lyrics of the song',
      name: 'songsEditScreen_lyricInput',
      desc: '',
      args: [],
    );
  }

  /// `More options`
  String get moreOptionsScreen_title {
    return Intl.message(
      'More options',
      name: 'moreOptionsScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `No name`
  String get moreOptionsScreen_noName {
    return Intl.message(
      'No name',
      name: 'moreOptionsScreen_noName',
      desc: '',
      args: [],
    );
  }

  /// `No email`
  String get moreOptionsScreen_noEmail {
    return Intl.message(
      'No email',
      name: 'moreOptionsScreen_noEmail',
      desc: '',
      args: [],
    );
  }

  /// `Metrics`
  String get moreOptionsScreen_metrics {
    return Intl.message(
      'Metrics',
      name: 'moreOptionsScreen_metrics',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get moreOptionsScreen_groups {
    return Intl.message(
      'Groups',
      name: 'moreOptionsScreen_groups',
      desc: '',
      args: [],
    );
  }

  /// `Scan lyrics`
  String get moreOptionsScreen_scanLyrics {
    return Intl.message(
      'Scan lyrics',
      name: 'moreOptionsScreen_scanLyrics',
      desc: '',
      args: [],
    );
  }

  /// `Font size`
  String get moreOptionsScreen_fontSize {
    return Intl.message(
      'Font size',
      name: 'moreOptionsScreen_fontSize',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get moreOptionsScreen_lang {
    return Intl.message(
      'Language',
      name: 'moreOptionsScreen_lang',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get moreOptionsScreen_logout {
    return Intl.message(
      'Logout',
      name: 'moreOptionsScreen_logout',
      desc: '',
      args: [],
    );
  }

  /// `Hold the button and start speaking`
  String get spechToTextBotomShet_holdBtn {
    return Intl.message(
      'Hold the button and start speaking',
      name: 'spechToTextBotomShet_holdBtn',
      desc: '',
      args: [],
    );
  }

  /// `Now I'm listening... release the stop button`
  String get spechToTextBotomShet_releaseBtn {
    return Intl.message(
      'Now I\'m listening... release the stop button',
      name: 'spechToTextBotomShet_releaseBtn',
      desc: '',
      args: [],
    );
  }

  /// `I didn't understand, say it again`
  String get spechToTextBotomShet_noUnderstand {
    return Intl.message(
      'I didn\'t understand, say it again',
      name: 'spechToTextBotomShet_noUnderstand',
      desc: '',
      args: [],
    );
  }

  /// `Setlists`
  String get setlistsListScreen_title {
    return Intl.message(
      'Setlists',
      name: 'setlistsListScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Create Setlist`
  String get setlistsCreateScreen_title {
    return Intl.message(
      'Create Setlist',
      name: 'setlistsCreateScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get setlistsCreateScreen_nameInput {
    return Intl.message(
      'Name',
      name: 'setlistsCreateScreen_nameInput',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get setlistsCreateScreen_createButtonText {
    return Intl.message(
      'Create',
      name: 'setlistsCreateScreen_createButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Edit Setlist`
  String get setlistsEditScreen_title {
    return Intl.message(
      'Edit Setlist',
      name: 'setlistsEditScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get setlistsEditScreen_nameInput {
    return Intl.message(
      'Name',
      name: 'setlistsEditScreen_nameInput',
      desc: '',
      args: [],
    );
  }

  /// `Delete setlist?`
  String get setlistsDelete_title {
    return Intl.message(
      'Delete setlist?',
      name: 'setlistsDelete_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete setlists?`
  String get setlistsDelete_titlePlural {
    return Intl.message(
      'Delete setlists?',
      name: 'setlistsDelete_titlePlural',
      desc: '',
      args: [],
    );
  }

  /// `Delete setlist`
  String get setlistsDelete_deleteButton {
    return Intl.message(
      'Delete setlist',
      name: 'setlistsDelete_deleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete {setlistsCount} setlists`
  String setlistsDelete_deleteButtonPlural(int setlistsCount) {
    return Intl.message(
      'Delete $setlistsCount setlists',
      name: 'setlistsDelete_deleteButtonPlural',
      desc: '',
      args: [setlistsCount],
    );
  }

  /// `Remove song from setlist?`
  String get setlistSongsRemove_title {
    return Intl.message(
      'Remove song from setlist?',
      name: 'setlistSongsRemove_title',
      desc: '',
      args: [],
    );
  }

  /// `Remove songs from setlist?`
  String get setlistSongsRemove_titlePlural {
    return Intl.message(
      'Remove songs from setlist?',
      name: 'setlistSongsRemove_titlePlural',
      desc: '',
      args: [],
    );
  }

  /// `Remove song from setlist`
  String get setlistSongsRemove_removeButton {
    return Intl.message(
      'Remove song from setlist',
      name: 'setlistSongsRemove_removeButton',
      desc: '',
      args: [],
    );
  }

  /// `Remove {songsCount} songs from setlist`
  String setlistSongsRemove_removeButtonPlural(int songsCount) {
    return Intl.message(
      'Remove $songsCount songs from setlist',
      name: 'setlistSongsRemove_removeButtonPlural',
      desc: '',
      args: [songsCount],
    );
  }

  /// `Change font size`
  String get changefontSizeScreen_title {
    return Intl.message(
      'Change font size',
      name: 'changefontSizeScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Here you can change the font size that is displayed when reading a song.`
  String get changefontSizeScreen_subtitle {
    return Intl.message(
      'Here you can change the font size that is displayed when reading a song.',
      name: 'changefontSizeScreen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Current value`
  String get changefontSizeScreen_currentValue {
    return Intl.message(
      'Current value',
      name: 'changefontSizeScreen_currentValue',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get changeLangScreen_title {
    return Intl.message(
      'Change language',
      name: 'changeLangScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Here you can change the language of the app.`
  String get changeLangScreen_subtitle {
    return Intl.message(
      'Here you can change the language of the app.',
      name: 'changeLangScreen_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get changeLangScreen_es {
    return Intl.message(
      'Spanish',
      name: 'changeLangScreen_es',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get changeLangScreen_en {
    return Intl.message(
      'English',
      name: 'changeLangScreen_en',
      desc: '',
      args: [],
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
