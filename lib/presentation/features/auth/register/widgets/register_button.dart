import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/config.dart';
import '/presentation/features/auth/register/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';


class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final provider = ref.watch(registerProvider);
    final lang = Lang.of(context);

    return SendProviderBuilder(
      provider: registerProvider,
      loaderWidget: BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.loginScreen_buttonText
      ),
      child: BasicButton(
        onPressed: provider.isFormValid ?
        () => provider.tryRegister() 
        : null, 
        text: lang.registerScreen_registerButton
      ),
    );
  }
}
