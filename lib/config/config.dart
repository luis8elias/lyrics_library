import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/presentation/presentation.dart';
import '/utils/db/sqlite.dart';
import '/utils/utils.dart';

export '/config/lang/generated/l10n.dart';
export '/config/routes/register_routes.dart';
export '/config/routes/routes.dart';
export '/config/themes/dark_theme.dart';

class Config{
  static const defaultLocale = Locale('es');
  static const initialLocation = LoginScreen.routeName;
  static final serverClientID = dotenv.env['SERVER_CLIENT_ID'];
  static final androidClientId = dotenv.env['ANDROID_CLIENT_ID'];
  static final iosClientId = dotenv.env['IOS_CLIENT_IOS'];
  static final apiUrl = dotenv.env['API_URL'];
  static const songsPageSize = 100;
  static const defaultReadSongFontSize = 15.0;
  static const manualLocalServicesDelay = Duration(milliseconds: 250);
  static const preferredOrientations = [
    DeviceOrientation.portraitUp, 
    DeviceOrientation.portraitDown,
  ];
  

  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    ServicesRegister.start();
    SystemChrome.setPreferredOrientations(
      Config.preferredOrientations
    );
    await SQLite.initializeDatabase();
    await dotenv.load(fileName: ".env");
  }
}

