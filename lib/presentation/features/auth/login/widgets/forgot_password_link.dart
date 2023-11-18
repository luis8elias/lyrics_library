import 'package:flutter/material.dart';

import '/config/lang/generated/l10n.dart';
import '/utils/utils.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        ),
        onTap: (){
          //GoRouter.of(context).pushNamed(GetRecoveryCodeScreen.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.kPadding /2 ,
            horizontal: Sizes.kPadding,
          ),
          child: Text(
            lang.loginScreen_forgotYourPasswordLink,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.tertiary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}