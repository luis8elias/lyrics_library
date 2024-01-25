import 'package:flutter/material.dart';
import 'package:lyrics_library/presentation/widgets/custom_bottom_nav_bar.dart';

class SetlistsScreen extends StatelessWidget {
  const SetlistsScreen({super.key});

  
  static const String routeName = '/setlists';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 1,
        body: Center(
          child: Text('Setlists'),
        ),
      ),
    );
  }
}