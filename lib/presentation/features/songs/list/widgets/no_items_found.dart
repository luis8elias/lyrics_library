import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';

class NoSongsFound extends StatelessWidget {
  const NoSongsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - Sizes.kBottomNavHeight,
      child: const Center(child: Text('No items'))
    );
  }
}