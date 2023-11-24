import 'dart:io';

import 'package:flutter/material.dart';

import '/presentation/widgets/loaders.dart';
import '/utils/constants/sizes.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {

    final progressIndicatorPadding = Platform.isIOS 
    ? Sizes.kBottomNavHeight : Sizes.kBottomNavHeight + 30;
    
    return Padding(
      padding:  EdgeInsets.only(
        top: 20,
        bottom: progressIndicatorPadding
      ),
      child: const LoadingWidget(),
    );
  }
}