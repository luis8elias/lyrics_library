import 'package:flutter/material.dart';

import '/config/lang/generated/l10n.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4
            ),
            height: 1,
            color: theme.dividerColor,
          )
        ),
        Text(
          lang.loginScreen_alternativesDivider,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 12
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4
              ),
              height: 1,
              color: theme.dividerColor,
            ),
          )
        ),
      ],
    );
  }
}