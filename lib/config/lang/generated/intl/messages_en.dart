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

  static String m1(songsCount) => "Delete ${songsCount} songs";

  static String m2(length) => "Password must be at least ${length} characters";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actions_back": MessageLookupByLibrary.simpleMessage("Back"),
        "actions_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "actions_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "actions_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "actions_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "actions_save": MessageLookupByLibrary.simpleMessage("Save"),
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
        "songsCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Create Song"),
        "songsCreateScreen_titleInput":
            MessageLookupByLibrary.simpleMessage("Title"),
        "songsDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Delete song"),
        "songsDelete_deleteButtonPlural": m1,
        "songsDelete_title":
            MessageLookupByLibrary.simpleMessage("Delete song?"),
        "songsDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("Delete songs?"),
        "songsEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Edit Song"),
        "songsEditScreen_titleInput":
            MessageLookupByLibrary.simpleMessage("Title"),
        "songsListScreen_title": MessageLookupByLibrary.simpleMessage("Songs"),
        "validator_confirmPassword":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "validator_confirmPasswordLength": m2,
        "validator_email": MessageLookupByLibrary.simpleMessage("Wrong email"),
        "validator_required":
            MessageLookupByLibrary.simpleMessage("This field is required")
      };
}
