import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lyrics_library/presentation/widgets/buttons.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/delete/delete_genre_button.dart';
import '/presentation/features/genres/list/providers/providers.dart';
import '/presentation/features/genres/list/widgets/genres_leading.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/presentation.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/search_input.dart';
import '/utils/constants/sizes.dart';

class GenresListScreen extends ConsumerStatefulWidget {
  const GenresListScreen({super.key});

  static const String routeName = '/genres';

  @override
  ConsumerState<GenresListScreen> createState() => _GenresListScreenState();
}

class _GenresListScreenState extends ConsumerState<GenresListScreen> {

  bool showSearchInput = false;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final prov = ref.read(genresListProvider);
    final reactiveProv = ref.watch(genresListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 60.0;
   
    return  Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 2,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.colorScheme.inverseSurface.withOpacity(0.5),
          leading: const GenresLeading(),
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
                right: Sizes.kPadding/2
              ),
              child: CreateButton(
                onPressed:()=> GoRouter.of(context).pushNamed(
                  CreateGenreScreen.routeName
                ),
              )
            ),
          ],
          title: showSearchInput ? 
          SearchInput(
            onChangeSearch: (query) => prov.updateQuery(query),
          )
          : Text(
            lang.genresListScreen_title,
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
                      EditGenreScreen.routeName,
                      pathParameters: {
                        'gid': prov.getFirstGenreSelected.id.toString()
                      },
                    ),
                    extra: prov.getFirstGenreSelected
                  )
                  : null, 
                  child: Text(lang.actions_edit)
                ),
                DeleteGenreButton(
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
              height: 30,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kPadding
              ),
              width: double.infinity,
              color: theme.colorScheme.inverseSurface.withOpacity(0.5),
              child: Text(
                reactiveProv.isSelectItemOpened 
                ? '${reactiveProv.selectedItems.length} ${lang.app_selectedItems}'
                : reactiveProv.isModelInitialized ?
                 '${reactiveProv.model!.length  } ${lang.app_items}'
                 : '0 ${lang.app_items}',
                style: theme.textTheme.bodySmall,
              ),
            ),
            Expanded(
              child: FetchProviderBuilder(
                provider: genresListProvider,
                loaderWidget: const LoadingScreen(),
                builder: (genres){
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => prov.refreshGenres(),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Container(
                        height: 0.5,
                        color: theme.colorScheme.outline,
                      ),
                      itemCount: genres!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: (index+1) == genres.length ? bottomPadding : 0,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.kPadding,
                            vertical: Sizes.kPadding * 0.5,
                          ),
                          onTap: prov.isSelectItemOpened  
                          ? ()=> prov.selectItem(id: genres[index].id)
                          : ()=> GoRouter.of(context).go(
                            context.namedLocation(
                              EditGenreScreen.routeName,
                              pathParameters: {
                                'gid': genres[index].id.toString()
                              },
                            ),
                            extra: genres[index]
                          ),
                          onLongPress: prov.isSelectItemOpened 
                          ? null 
                          : ()=> prov.openCloseSelectItem(
                            id: genres[index].id
                          ),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(reactiveProv.isSelectItemOpened)
                              FadeInLeft(
                                duration: const Duration(milliseconds: 100),
                                child: CupertinoCheckbox(
                                  checkColor: theme.colorScheme.onPrimary,
                                  activeColor: theme.colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                                  ),
                                  value: reactiveProv.selectedItems.contains(genres[index].id), 
                                  onChanged: (value){
                                    prov.selectItem(
                                      id: genres[index].id
                                    );
                                  },
                                ),
                              ),
                              
                              if(reactiveProv.isSelectItemOpened)
                              const SizedBox(
                                width: Sizes.kPadding,
                              ),
                              
                              reactiveProv.isSelectItemOpened 
                              ? FadeInLeft(
                                duration: const Duration(milliseconds: 100),
                                child: _GenreTileLeading(
                                  genreModel: genres[index],
                                ),
                              )
                              : FadeInRight(
                                duration: const Duration(milliseconds: 100),
                                child: _GenreTileLeading(
                                  genreModel: genres[index],
                                ),
                              ),
                            ],
                          ),
                          title: reactiveProv.isSelectItemOpened 
                          ? FadeInLeft(
                            duration: const Duration(milliseconds: 100),
                            child: Text(
                              genres[index].name,
                              style: theme.textTheme.displaySmall,
                            ),
                          )
                          : FadeInRight(
                            duration: const Duration(milliseconds: 100),
                            child: Text(
                              genres[index].name,
                              style: theme.textTheme.displaySmall,
                            ),
                          ) ,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      )
    );
  }
}


class _GenreTileLeading extends StatelessWidget {
  const _GenreTileLeading({
    required this.genreModel
  });

  final GenreModel genreModel;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorScheme.primary
        ),
      ),
      child: 
      Center(
        child: Text(
          genreModel.nameInitials,
          style: TextStyle(
            fontSize: 18,
            color: theme.colorScheme.onBackground,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}