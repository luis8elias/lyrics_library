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
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/search_input.dart';
import '/presentation/widgets/widgets.dart';
import '/utils/constants/sizes.dart';
import '/utils/utils.dart';

class SetlistsScreen extends ConsumerStatefulWidget {
  const SetlistsScreen({super.key});

  
  static const String routeName = '/setlists';

  @override
  ConsumerState<SetlistsScreen> createState() => _SetlistsScreenState();
}

class _SetlistsScreenState extends ConsumerState<SetlistsScreen> {

  bool showSearchInput = false;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final prov = ref.read(setlistsListProvider);
    final reactiveProv = ref.watch(setlistsListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 60.0;
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomBottomNavBar(
          selectedIndex: 1,
          appBar: AppBar(
            centerTitle: true,
            leading: const SetlistsLeading(),
            actions: [
              if(!showSearchInput)
              IconButton(
                iconSize: 25,
                onPressed: (){
                  setState(() {
                    showSearchInput = true;
                  });
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              showSearchInput 
              ? FadeIn(
                child: TextButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerRight,
                    textStyle: theme.textTheme.labelLarge,
                  ),
                  onPressed: (){
                    setState(() {
                      showSearchInput = false;
                    });
                    prov.updateQuery('');
                  },
                  child: Text(
                    lang.actions_cancel
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.kPadding / 2,
                ),
                child: CreateButton(
                  onPressed: () => GoRouter.of(context).pushNamed(
                    CreateSetlistScreen.routeName
                  ),
                )
              ),
              
            ],
            title: showSearchInput ? 
            SearchInput(
              onChangeSearch: (query) => prov.updateQuery(query),
            )
            : Text(
              lang.setlistsListScreen_title,
              style: theme.textTheme.titleSmall,
            ),
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
                  ),
                ],
              ),
            ),
          )
          : null,
          body: Column(
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kPadding
                ),
                width: double.infinity,
                color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                child: Row(
                  children: [
                    Text(
                      reactiveProv.isSelectItemOpened 
                      ? '${reactiveProv.selectedItems.length} ${lang.app_selectedItems}'
                      : reactiveProv.isModelInitialized ?
                       '${reactiveProv.model!.length  } ${lang.app_items}'
                       : '0 ${lang.app_items}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FetchProviderBuilder(
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
            ],
          ),
        ),
      ),
    );
  }
}