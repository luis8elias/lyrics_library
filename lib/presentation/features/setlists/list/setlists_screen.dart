import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/delete/delete_setlist_button.dart';
import '/presentation/features/setlists/list/providers/providers.dart';
import '/presentation/features/setlists/list/widgets/setlist_tile.dart';
import '/presentation/features/setlists/list/widgets/setlists_leading.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/widgets.dart';
import '/utils/constants/sizes.dart';
import '/utils/utils.dart';
import 'widgets/create_setlist_btn.dart';

class SetlistsScreen extends ConsumerWidget {
  const SetlistsScreen({super.key});

  
  static const String routeName = '/setlists';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final prov = ref.read(setlistsListProvider);
    final reactiveProv = ref.watch(setlistsListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 60.0;
    
    return Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 1,
        appBar: AppBar(
          centerTitle: true,
          leading: const SetlistsLeading(),
          actions: [
            IconButton(
              iconSize: 25,
              onPressed: (){},
              icon: Icon(
                CupertinoIcons.search,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: Sizes.kPadding/2
              ),
              child: CreateSetlistBtn()
            ),
          ],
          title: Text(
            lang.setlistsListScreen_title,
            style: theme.textTheme.titleSmall,
          )
        ),
        buttonBottomRow: prov.isSelectItemOpened 
        ? FadeInUp(
          duration: const Duration(milliseconds: 100),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: reactiveProv.isOneItemSelected 
                  ? ()=> GoRouter.of(context).go(
                    context.namedLocation(
                      EditSetlistScreen.routeName,
                      pathParameters: {
                        'sid': prov.getFirstSetlistSelected.id.toString()
                      },
                    ),
                    extra: prov.getFirstSetlistSelected
                  )
                  : null,
                  child: Text(lang.actions_edit)
                ),
                DeleteSetlistButton(
                  enabled: reactiveProv.selectedItems.isNotEmpty
                )
              ],
            ),
          ),
        )
        : null,
        body: FetchProviderBuilder(
          provider: setlistsListProvider,
          loaderWidget: const LoadingScreen(),
          builder:(setlists) {
            return RefreshIndicator(
              onRefresh: () => Future.sync(
                () => prov.refreshSetlists(),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 0.5,
                  color: theme.colorScheme.outline,
                ),
                itemCount: setlists!.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: (index+1) == setlists.length ? bottomPadding : 0,
                  ),
                  child: SetlistTile(
                    setlistModel: setlists[index]
                  ),
                )
              ),
            );
          },
        ),
      ),
    );
  }
}