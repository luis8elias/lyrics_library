import 'dart:io';

import 'package:flutter/material.dart';

import '/presentation/presentation.dart';
import '/utils/utils.dart';


class BasicButton extends StatelessWidget {
  const BasicButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.buildChild
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Widget Function(Widget loadingChild)? buildChild;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final loadingChild = SizedBox(
      height: Platform.isIOS ? 10 : 20,
      child: LoadingWidget(
        iosSize: 10,
        androidSize: 20,
        androidProgressColor: theme.colorScheme.onBackground,
      ),
    );

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.onPrimary,
        minimumSize: const Size(4,4),
        backgroundColor: onPressed != null 
        ? theme.primaryColor : theme.primaryColor.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius)
        )
      ),
      onPressed: onPressed, 
      child: SizedBox(
        width: double.maxFinite, 
        child: buildChild != null 
        ? buildChild!(loadingChild)
        : Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );
  }
}

class BasicOutlinedIconButton extends StatelessWidget {
  const BasicOutlinedIconButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.bgColor,
    this.buildChild
  });

  final VoidCallback? onPressed;
  final String text;
  final Widget icon;
  final Color? bgColor;
  final Widget Function(Widget loadingChild)? buildChild;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final loadingChild = LoadingWidget(
      iosSize: 10,
      androidSize: 20,
      androidProgressColor: theme.colorScheme.onBackground,
    );

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.primary.withOpacity(0.5),
        minimumSize: const Size(4,4),
        backgroundColor: bgColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.colorScheme.onBackground
          ),
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius)
        )
      ),
      onPressed: onPressed, 
      child: SizedBox(
        width: double.maxFinite, 
        child: buildChild != null 
        ? buildChild!(loadingChild)
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: Sizes.kPadding,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        )
      )
    );
  }
}