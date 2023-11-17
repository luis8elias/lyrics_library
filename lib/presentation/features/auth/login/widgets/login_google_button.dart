import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/auth/login/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';

class LoginGoogleButton extends ConsumerWidget {
  const LoginGoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.read(loginGoogleProvider);
    final theme = Theme.of(context);
    final lang = Lang.of(context);
    
    return SendProviderBuilder(
      provider: loginGoogleProvider,
      loaderWidget: BasicOutlinedIconButton(
        bgColor: theme.colorScheme.background,
        text: lang.loginScreen_signInWithGoogleButton, 
        icon: SizedBox(
          height: 20,
          width: 20,
          child: Image.asset('assets/img/google.png'),
        ),
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
      ),
      child: BasicOutlinedIconButton(
        bgColor: theme.colorScheme.background,
        text: lang.loginScreen_signInWithGoogleButton, 
        icon: SizedBox(
          height: 20,
          width: 20,
          child: Image.asset('assets/img/google.png'),
        ),
        onPressed: () => prov.tryLoginWithGoogle()
      ),
    );
  }
}