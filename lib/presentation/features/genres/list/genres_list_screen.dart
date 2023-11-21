import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/delete/delete_genre_button.dart';
import '/presentation/features/genres/list/providers/providers.dart';
import '/presentation/features/genres/list/widgets/genres_leading.dart';
import '/presentation/presentation.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/transparent_appbar.dart';
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
    final reactiveProv = ref.watch(genresListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 60.0;
    final topPadding = Platform.isIOS ? 30.0 : 40.0;
   
    return  Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 2,
        scaffoldKey: key,
        appBar: CustomAppBar(
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
          leading: const GenresLeading(),
          title: lang.genresListScreen_title
        ),
        buttonBottomRow: prov.isSelectGenreOpened 
        ? FadeInUp(
          duration: const Duration(milliseconds: 100),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: reactiveProv.isOneGenreSelected 
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
                  enabled: reactiveProv.selectedGenres.isNotEmpty
                ),
              ],
            ),
          ),
        )
        : null,
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
                    displacement: 100,
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
                          top: index == 0 ? topPadding : 0,
                        ),
                        child: ListTile(
                          onTap: prov.isSelectGenreOpened  
                          ? ()=> prov.selectGenre(genres[index].id)
                          : ()=> GoRouter.of(context).go(
                            context.namedLocation(
                              EditGenreScreen.routeName,
                              pathParameters: {
                                'gid': genres[index].id.toString()
                              },
                            ),
                            extra: genres[index]
                          ),
                          onLongPress: prov.isSelectGenreOpened 
                          ? null 
                          : ()=> prov.openCloseSelectGenre(
                            genreId: genres[index].id
                          ),
                          leading: reactiveProv.isSelectGenreOpened ? FadeInLeft(
                            duration: const Duration(milliseconds: 100),
                            child: CupertinoCheckbox(
                              checkColor: theme.colorScheme.onPrimary,
                              activeColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                              ),
                              value: reactiveProv.selectedGenres.contains(genres[index].id), 
                              onChanged: (value){
                                prov.selectGenre(genres[index].id);
                              },
                            ),
                          ) : null,
                          title: reactiveProv.isSelectGenreOpened 
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
                  )
                ),
              ],
            );
          },
        )
      )
    );
  }
}