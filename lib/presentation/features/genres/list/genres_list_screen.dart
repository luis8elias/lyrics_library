import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lyrics_library/presentation/presentation.dart';
import 'package:lyrics_library/utils/extensions/string_extensions.dart';

import '/presentation/features/genres/list/providers/providers.dart';
import '/presentation/widgets/providers.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/utils/constants/sizes.dart';

class GenresListScreen extends ConsumerWidget {
  const GenresListScreen({super.key});

   static const String routeName = '/genres';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final GlobalKey<ScaffoldState> key = GlobalKey();
    final prov = ref.read(genresListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 70.0;
   
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text(
          lang.genresListScreen_title,
          style: theme.textTheme.titleSmall,
        ),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            CupertinoIcons.ellipsis_circle,
            color: theme.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Sizes.kPadding/2
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius),
              onTap: () => GoRouter.of(context).pushNamed(CreateGenreScreen.routeName),
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
          ),
        ],
      ),
      body: CustomBottomNavBar(
        selectedIndex: 2,
        scaffoldKey: key,
        body: FetchProviderBuilder(
          provider: genresListProvider,
          loaderWidget: const LoadingScreen(),
          builder: (genres){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Sizes.kPadding/2,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => prov.refreshGenres(),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 0.09,
                      ),
                      itemCount: genres!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: (index+1) == genres.length ? bottomPadding : 0
                        ),
                        child: ListTile(
                          title: Text(
                            genres[index].name.capitalize(),
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                  )
                )
                
              ],
            );
          },
        )
      )
    );
  }
}