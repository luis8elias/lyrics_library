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

  static String m0(genresCount) => "Eliminar ${genresCount} géneros";

  static String m1(setlistsCount) => "Eliminar ${setlistsCount} listas";

  static String m2(songsCount) => "Eliminar ${songsCount} géneros";

  static String m3(length) =>
      "La contraseña debe ser como mínimo de ${length} caracteres";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actions_back": MessageLookupByLibrary.simpleMessage("Volver"),
        "actions_cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "actions_delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "actions_edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "actions_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "actions_save": MessageLookupByLibrary.simpleMessage("Guardar"),
        "actions_search": MessageLookupByLibrary.simpleMessage("Buscar"),
        "app_favorites": MessageLookupByLibrary.simpleMessage("Favoritos"),
        "app_genres": MessageLookupByLibrary.simpleMessage("Géneros"),
        "app_items": MessageLookupByLibrary.simpleMessage("Elementos"),
        "app_more": MessageLookupByLibrary.simpleMessage("Más"),
        "app_selectedItems":
            MessageLookupByLibrary.simpleMessage("Elementos seleccionados"),
        "app_setlists": MessageLookupByLibrary.simpleMessage("Listas"),
        "app_songs": MessageLookupByLibrary.simpleMessage("Canciones"),
        "genresCreateScreen_createButtonText":
            MessageLookupByLibrary.simpleMessage("Crear"),
        "genresCreateScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "genresCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Crear Género"),
        "genresDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Eliminar género"),
        "genresDelete_deleteButtonPlural": m0,
        "genresDelete_title":
            MessageLookupByLibrary.simpleMessage("¿Eliminar género?"),
        "genresDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("¿Eliminar géneros?"),
        "genresEditScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "genresEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Editar Género"),
        "genresListScreen_title":
            MessageLookupByLibrary.simpleMessage("Géneros"),
        "loadingScreen_loading":
            MessageLookupByLibrary.simpleMessage("Cargando..."),
        "loginScreen_alternativesDivider":
            MessageLookupByLibrary.simpleMessage("Ó"),
        "loginScreen_buttonText":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "loginScreen_emailInput":
            MessageLookupByLibrary.simpleMessage("Correo electrónico"),
        "loginScreen_forgotYourPasswordLink":
            MessageLookupByLibrary.simpleMessage("¿Olvidaste tu contraseña?"),
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
        "moreOptionsScreen_fontSize":
            MessageLookupByLibrary.simpleMessage("Tamaño de letra"),
        "moreOptionsScreen_groups":
            MessageLookupByLibrary.simpleMessage("Grupos"),
        "moreOptionsScreen_lang":
            MessageLookupByLibrary.simpleMessage("Lenguaje"),
        "moreOptionsScreen_logout":
            MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "moreOptionsScreen_metrics":
            MessageLookupByLibrary.simpleMessage("Metricas"),
        "moreOptionsScreen_noEmail":
            MessageLookupByLibrary.simpleMessage("Sin correo electrónico"),
        "moreOptionsScreen_noName":
            MessageLookupByLibrary.simpleMessage("Sin nombre"),
        "moreOptionsScreen_scanLyrics":
            MessageLookupByLibrary.simpleMessage("Escanear letras"),
        "moreOptionsScreen_title":
            MessageLookupByLibrary.simpleMessage("Más opciones"),
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
        "setlistsCreateScreen_createButtonText":
            MessageLookupByLibrary.simpleMessage("Crear"),
        "setlistsCreateScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "setlistsCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Crear lista"),
        "setlistsDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Eliminar lista"),
        "setlistsDelete_deleteButtonPlural": m1,
        "setlistsDelete_title":
            MessageLookupByLibrary.simpleMessage("¿Eliminar lista?"),
        "setlistsDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("¿Eliminar listas?"),
        "setlistsEditScreen_nameInput":
            MessageLookupByLibrary.simpleMessage("Nombre"),
        "setlistsEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Editar lista"),
        "setlistsListScreen_title":
            MessageLookupByLibrary.simpleMessage("Listas"),
        "songsCreateScreen_title":
            MessageLookupByLibrary.simpleMessage("Crear Canción"),
        "songsCreateScreen_titleInput":
            MessageLookupByLibrary.simpleMessage("Título"),
        "songsDelete_deleteButton":
            MessageLookupByLibrary.simpleMessage("Eliminar canción"),
        "songsDelete_deleteButtonPlural": m2,
        "songsDelete_title":
            MessageLookupByLibrary.simpleMessage("¿Eliminar canción?"),
        "songsDelete_titlePlural":
            MessageLookupByLibrary.simpleMessage("¿Eliminar canciones?"),
        "songsEditScreen_title":
            MessageLookupByLibrary.simpleMessage("Edita Canción"),
        "songsEditScreen_titleInput":
            MessageLookupByLibrary.simpleMessage("Título"),
        "songsListScreen_title":
            MessageLookupByLibrary.simpleMessage("Canciones"),
        "spechToTextBotomShet_holdBtn": MessageLookupByLibrary.simpleMessage(
            "Presiona el botón y comienza a hablar"),
        "spechToTextBotomShet_noUnderstand":
            MessageLookupByLibrary.simpleMessage("No entendí dilo de nuevo"),
        "spechToTextBotomShet_releaseBtn": MessageLookupByLibrary.simpleMessage(
            "Ahora estoy escuchando... suelte el botón para detener"),
        "validator_confirmPassword": MessageLookupByLibrary.simpleMessage(
            "Las contraseñas no coinciden"),
        "validator_confirmPasswordLength": m3,
        "validator_email":
            MessageLookupByLibrary.simpleMessage("Correo incorrecto"),
        "validator_required":
            MessageLookupByLibrary.simpleMessage("Este campo es obligatorio")
      };
}
