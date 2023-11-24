import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/config/config.dart';
import '/utils/utils.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});


  static const String routeName = '/loading-screen';

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
   
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(Platform.isIOS)...[
              CupertinoActivityIndicator(
                color: theme.colorScheme.onSecondary,
                radius: 15,
              ),
            ],
            if(Platform.isAndroid)...[
              CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            ],
            const SizedBox(
              width: Sizes.kPadding,
            ),
            Text(
              lang.loadingScreen_loading,
              style: theme.textTheme.bodyMedium,
            )
          ],
        )
      ),
    );
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.padding = EdgeInsets.zero,
    this.iosSize,
    this.androidSize,
    this.androidProgressColor,
    this.strokeWidth = 4.0
  });

  final EdgeInsets padding;
  final double? iosSize;
  final double? androidSize;
  final Color? androidProgressColor;
  final double strokeWidth;
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    if(Platform.isIOS){
      return  Center(
        child: Padding(
          padding: padding,
          child: CupertinoActivityIndicator(
            radius: iosSize ?? 15,
            color: theme.colorScheme.onBackground,
          )
        ),
      );
    }

    if(androidSize != null){
      return  Center(
        child: Padding(
          padding: padding,
          child: SizedBox(
            height: androidSize,
            width: androidSize,
            child: CircularProgressIndicator(
              color: androidProgressColor ?? theme.primaryColor,
              strokeWidth: strokeWidth,
            ),
          ),
        ),
      );
    }
   
    return  Center(
      child: Padding(
        padding: padding,
        child: CircularProgressIndicator(
          color: androidProgressColor ?? theme.primaryColor,
        ),
      ),
    );
  }
}
