// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(length) =>
      "La contraseña debe ser como mínimo de ${length} caracteres";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "loadingScreen_loading":
            MessageLookupByLibrary.simpleMessage("Cargando..."),
        "loginScreen_alternativesDivider":
            MessageLookupByLibrary.simpleMessage("Ó"),
        "loginScreen_buttonText":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "loginScreen_emailInput":
            MessageLookupByLibrary.simpleMessage("Correo electrónico"),
        "loginScreen_passwordInput":
            MessageLookupByLibrary.simpleMessage("Contraseña"),
        "loginScreen_registerLink":
            MessageLookupByLibrary.simpleMessage(" Regístrate"),
        "loginScreen_registerLinkText":
            MessageLookupByLibrary.simpleMessage("¿No tines una cuenta?"),
        "loginScreen_signInWithGoogleButton":
            MessageLookupByLibrary.simpleMessage("Inicia sesión con Google"),
        "loginScreen_welcome": MessageLookupByLibrary.simpleMessage(
            "¡Bienvenido! ¡Me alegra verte de nuevo!"),
        "registerScreen_confrimPasswordInput":
            MessageLookupByLibrary.simpleMessage("Confirmar contraseña"),
        "registerScreen_emailInput":
            MessageLookupByLibrary.simpleMessage("orreo electrónico"),
        "registerScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Nombre(s)"),
        "registerScreen_passwordInput":
            MessageLookupByLibrary.simpleMessage("Contraseña"),
        "registerScreen_registerButton":
            MessageLookupByLibrary.simpleMessage("Regístrarse"),
        "registerScreen_title": MessageLookupByLibrary.simpleMessage(
            "¡Hola! Regístrese para comenzar"),
        "validator_confirmPassword": MessageLookupByLibrary.simpleMessage(
            "Las contraseñas no coinciden"),
        "validator_confirmPasswordLength": m0,
        "validator_email":
            MessageLookupByLibrary.simpleMessage("Correo incorrecto"),
        "validator_required":
            MessageLookupByLibrary.simpleMessage("Este campo es obligatorio")
      };
}
