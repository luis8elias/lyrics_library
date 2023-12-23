import 'dart:ui';

import 'package:flutter/material.dart';

import '/presentation/widgets/transparent_appbar.dart';
import '/utils/constants/sizes.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.appBar,
    required this.body,
    this.resizeToAvoidBottomInset = false
  });

  final Widget body;
  final CustomAppBar? appBar;
  final bool resizeToAvoidBottomInset; 

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        children: [
          Positioned.fill(
            child: body,
          ),
          if(appBar != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: Sizes.kAppBarSize,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: appBar,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}