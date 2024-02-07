import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/config.dart';
import '/app/app.dart';



void main() async{
  await Config.initializeApp();
  runApp(
    const ProviderScope(
      child: App()
    ),
  );
}