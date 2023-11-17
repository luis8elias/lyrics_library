import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/widgets/buttons.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/features/auth/login/providers/providers.dart';
import '/presentation/widgets/providers.dart';



class StartButton extends ConsumerWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    
    final provider = ref.watch(loginProvider);
    final lang = Lang.of(context);

    return SendProviderBuilder(
      provider: loginProvider,
      loaderWidget: BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.loginScreen_buttonText
      ),
      child: BasicButton(
        onPressed: provider.isFormValid ?
        () => provider.tryLogin() 
        : null, 
        text: lang.loginScreen_buttonText
      ),
    );
  }
}