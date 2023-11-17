import 'package:flutter/material.dart';
import '/utils/utils.dart';

class SnackbarHelper{

  static void show(BuildContext context, String message){

    final brightness = Theme.of(context).brightness;
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(Sizes.kPadding),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius)
        ),
        backgroundColor: brightness == Brightness.light ? Colors.black : Colors.white,
        content: Center(
          child: Text(
            message,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        )
      )
    );
  }
}