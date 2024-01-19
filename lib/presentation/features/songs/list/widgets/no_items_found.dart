import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';

class NoSongsFound extends StatelessWidget {
  const NoSongsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - Sizes.kBottomNavHeight,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No items'),
            SizedBox(
              height: Sizes.kBottomNavHeight,
            )
          ],
        ),
      ),
    );
  }
}