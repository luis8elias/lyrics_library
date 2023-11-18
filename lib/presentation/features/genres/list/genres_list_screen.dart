import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyrics_library/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';

class GenresListScreen extends ConsumerWidget {
  const GenresListScreen({super.key});

   static const String routeName = '/genres';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final GlobalKey<ScaffoldState> key = GlobalKey();
   
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.kPadding
          ),
          child: IconButton(
            onPressed: (){},
            icon: Icon(
              CupertinoIcons.ellipsis_circle,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Sizes.kPadding
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius),
              onTap: (){},
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                ),
                child: Icon(
                  CupertinoIcons.add,
                  color: theme.colorScheme.onPrimary,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
      body: CustomBottomNavBar(
        selectedIndex: 2,
        scaffoldKey: key,
        body: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.kPadding
            ),
            child: Text('genres')
          ),
        ),
      )
    );
  }
}