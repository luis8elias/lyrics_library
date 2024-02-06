import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/presentation/features/more/font_size/providers/change_font_size_provider.dart';

final changeFontSizeProvider = ChangeNotifierProvider.autoDispose<ChangeFontSizeProvider>((ref) {
  return ChangeFontSizeProvider(
    configService: Injector.appInstance.get()
  );
});