import 'package:flutter/material.dart';
import '/utils/utils.dart';

class SnackbarHelper{

  static void show({
    required BuildContext context,
    required String message, 
    Duration? duration
  }){

    final brightness = Theme.of(context).brightness;
    final theme = Theme.of(context);

    const defaultDuration = Duration(seconds: 2);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(Sizes.kPadding),
        behavior: SnackBarBehavior.floating,
        duration: duration ?? defaultDuration,
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