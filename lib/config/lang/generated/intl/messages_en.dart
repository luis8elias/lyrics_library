// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(genresCount) => "Delete ${genresCount} genres";

  static String m1(songsCount) => "Remove ${songsCount} songs from setlist";

  static String m2(setlistsCount) => "Delete ${setlistsCount} setlists";

  static String m3(songsCount) => "Delete ${songsCount} songs";

  static String m4(length) => "Password must be at least ${length} characters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actions_back": MessageLookupByLibrary.simpleMessage("Back"),
        "actions_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "actions_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "actions_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "actions_next": MessageLookupByLibrary.simpleMessage("Next"),
        "actions_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "actions_prev": MessageLookupByLibrary.simpleMessage("Prev"),
        "actions_remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "actions_save": MessageLookupByLibrary.simpleMessage("Save"),
        "actions_search": MessageLookupByLibrary.simpleMessage("Search"),
        "app_favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
        "app_genres": MessageLookupByLibrary.simpleMessage("Genres"),
        "app_items": MessageLookupByLibrary.simpleMessage("Items"),
        "app_more": MessageLookupByLibrary.simpleMessage("More"),
        "app_selectedItems":
            MessageLookupByLibrary.simpleMessage("Selected items"),
        "app_setlist": MessageLookupByLibrary.simpleMessage("Setlist"),
        "app_setlists": MessageLookupByLibrary.simpleMessage("Setlists"),
        "app_songs": MessageLookupByLibrary.simpleMessage("Songs"),
        "genresCreateScreen_createButtonText":
            MessageLookupByLibrary.simpleMessage("Create"),
        "genresCreateScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Name"),
        "genresCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Create Genre"),
        "genresDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Delete genre"),
        "genresDelete_deleteButtonPlural": m0,
        "genresDelete_title":
            MessageLookupByLibrary.simpleMessage("Delete genre?"),
        "genresDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("Delete genres?"),
        "genresEditScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Name"),
        "genresEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Edit Genre"),
        "genresListScreen_title":
            MessageLookupByLibrary.simpleMessage("Genres"),
        "loadingScreen_loading":
            MessageLookupByLibrary.simpleMessage("Loading..."),
        "loginScreen_alternativesDivider":
            MessageLookupByLibrary.simpleMessage("Or"),
        "loginScreen_buttonText": MessageLookupByLibrary.simpleMessage("Login"),
        "loginScreen_emailInput": MessageLookupByLibrary.simpleMessage("Email"),
        "loginScreen_forgotYourPasswordLink":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "loginScreen_passwordInput":
            MessageLookupByLibrary.simpleMessage("Password"),
        "loginScreen_registerLink":
            MessageLookupByLibrary.simpleMessage(" Register"),
        "loginScreen_registerLinkText":
            MessageLookupByLibrary.simpleMessage("You do not have an account?"),
        "loginScreen_signInWithGoogleButton":
            MessageLookupByLibrary.simpleMessage("Login with Google"),
        "loginScreen_welcome": MessageLookupByLibrary.simpleMessage(
            "Welcome! glad to see you again!"),
        "moreOptionsScreen_fontSize":
            MessageLookupByLibrary.simpleMessage("Font size"),
        "moreOptionsScreen_groups":
            MessageLookupByLibrary.simpleMessage("Groups"),
        "moreOptionsScreen_lang":
            MessageLookupByLibrary.simpleMessage("Language"),
        "moreOptionsScreen_logout":
            MessageLookupByLibrary.simpleMessage("Logout"),
        "moreOptionsScreen_metrics":
            MessageLookupByLibrary.simpleMessage("Metrics"),
        "moreOptionsScreen_noEmail":
            MessageLookupByLibrary.simpleMessage("No email"),
        "moreOptionsScreen_noName":
            MessageLookupByLibrary.simpleMessage("No name"),
        "moreOptionsScreen_scanLyrics":
            MessageLookupByLibrary.simpleMessage("Scan lyrics"),
        "moreOptionsScreen_title":
            MessageLookupByLibrary.simpleMessage("More options"),
        "registerScreen_confrimPasswordInput":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "registerScreen_emailInput":
            MessageLookupByLibrary.simpleMessage("Email"),
        "registerScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Name"),
        "registerScreen_passwordInput":
            MessageLookupByLibrary.simpleMessage("Password"),
        "registerScreen_registerButton":
            MessageLookupByLibrary.simpleMessage("Register"),
        "registerScreen_title": MessageLookupByLibrary.simpleMessage(
            "Hello! Register to get started"),
        "setlistSongsRemove_removeButton":
            MessageLookupByLibrary.simpleMessage("Remove song from setlist"),
        "setlistSongsRemove_removeButtonPlural": m1,
        "setlistSongsRemove_title":
            MessageLookupByLibrary.simpleMessage("Remove song from setlist?"),
        "setlistSongsRemove_titlePlural":
            MessageLookupByLibrary.simpleMessage("Remove songs from setlist?"),
        "setlistsCreateScreen_createButtonText":
            MessageLookupByLibrary.simpleMessage("Create"),
        "setlistsCreateScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Name"),
        "setlistsCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Create Setlist"),
        "setlistsDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Delete setlist"),
        "setlistsDelete_deleteButtonPlural": m2,
        "setlistsDelete_title":
            MessageLookupByLibrary.simpleMessage("Delete setlist?"),
        "setlistsDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("Delete setlists?"),
        "setlistsEditScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Name"),
        "setlistsEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Edit Setlist"),
        "setlistsListScreen_title":
            MessageLookupByLibrary.simpleMessage("Setlists"),
        "songsCreateScreen_lyricInput": MessageLookupByLibrary.simpleMessage(
            "Write the lyrics of the song"),
        "songsCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Create Song"),
        "songsCreateScreen_titleInput":
            MessageLookupByLibrary.simpleMessage("Title"),
        "songsDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Delete song"),
        "songsDelete_deleteButtonPlural": m3,
        "songsDelete_title":
            MessageLookupByLibrary.simpleMessage("Delete song?"),
        "songsDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("Delete songs?"),
        "songsEditScreen_lyricInput": MessageLookupByLibrary.simpleMessage(
            "Write the lyrics of the song"),
        "songsEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Edit Song"),
        "songsEditScreen_titleInput":
            MessageLookupByLibrary.simpleMessage("Title"),
        "songsListScreen_title": MessageLookupByLibrary.simpleMessage("Songs"),
        "spechToTextBotomShet_holdBtn": MessageLookupByLibrary.simpleMessage(
            "Hold the button and start speaking"),
        "spechToTextBotomShet_noUnderstand":
            MessageLookupByLibrary.simpleMessage(
                "I didn\'t understand, say it again"),
        "spechToTextBotomShet_releaseBtn": MessageLookupByLibrary.simpleMessage(
            "Now I\'m listening... release the stop button"),
        "validator_confirmPassword":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "validator_confirmPasswordLength": m4,
        "validator_email": MessageLookupByLibrary.simpleMessage("Wrong email"),
        "validator_required":
            MessageLookupByLibrary.simpleMessage("This field is required")
      };
}
