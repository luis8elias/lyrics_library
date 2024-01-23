import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/widgets/custom_bottom_nav_bar.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //final theme = Theme.of(context);
   
    return  const Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 0,
        body: Placeholder(),
        // body: Center(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: Sizes.kPadding
        //     ),
        //     child: provider.isLoadingLogout 
        //     ? Center(
        //       child: BasicButton(
        //         onPressed: null,
        //         buildChild: (loadingChild) => loadingChild,
        //         text: ''
        //       ),
        //     )
        //     : BasicButton(
        //       onPressed:  () => provider.logoutUser(),
        //       text: 'Cerrar sesión'
        //     ),
        //   ),
        // ),
      ),
    );
  }
}