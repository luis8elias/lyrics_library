import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/config/config.dart';
import '/presentation/presentation.dart';
import '/utils/utils.dart';



class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);

    return SizedBox(
      width: double.maxFinite,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        ),
        onTap: (){
          GoRouter.of(context).pushNamed(RegisterScreen.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.kPadding /2 ,
            horizontal:  Sizes.kPadding,
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                text: lang.loginScreen_registerLinkText,
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: lang.loginScreen_registerLink,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}