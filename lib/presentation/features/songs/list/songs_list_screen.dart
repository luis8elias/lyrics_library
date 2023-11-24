import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/widgets/transparent_appbar.dart';
import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/presentation.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/utils/utils.dart';

class SongsListScreen extends ConsumerStatefulWidget {
  const SongsListScreen({super.key});

  static const String routeName = '/songs';

  @override
  ConsumerState<SongsListScreen> createState() => _SongsListScreenState();
}

class _SongsListScreenState extends ConsumerState<SongsListScreen> {

  @override
  void initState() {
    ref.read(songsListProvider).addListenerToPagingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> key = GlobalKey();
    final theme = Theme.of(context);
    final prov = ref.read(songsListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 70.0;
    final topPadding = Platform.isIOS ? 45.0 : 40.0;
    final progressIndicatorPadding = Platform.isIOS ? Sizes.kBottomNavHeight : Sizes.kBottomNavHeight + 30;

    return  Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 1,
        scaffoldKey: key,
        appBar: CustomAppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: Sizes.kPadding/2
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius),
                onTap: () => {},
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
          //leading: const GenresLeading(),
          leading: const SizedBox.shrink(),
          title: 'Songs'
        ),
        body: RefreshIndicator(
          displacement: 100,
          onRefresh: () => Future.sync(
            () => prov.songsController.refresh(),
          ),
          child: PagedListView<int, SongModel>.separated(
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.09,
            ),
            pagingController: prov.songsController,
            builderDelegate: PagedChildBuilderDelegate<SongModel>(
              firstPageProgressIndicatorBuilder: (context) => const LoadingScreen(),
              newPageProgressIndicatorBuilder: (context) => Padding(
                padding:  EdgeInsets.only(
                  top: 20,
                  bottom: progressIndicatorPadding
                ),
                child: const LoadingWidget(),
              ),
              itemBuilder: (context, item, index) {
                return Padding(
                padding: EdgeInsets.only(
                  //Comparar con totalSongs
                  bottom: (index+1) == prov.totalSongs ? bottomPadding : 0.0,
                  top: index == 0 ? topPadding : 0,
                ),
                child: ListTile(
                  title: Text(
                    item.title,
                    style: theme.textTheme.displaySmall,
                  ),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        if(item.genreModel != null)
                        Container(
                          height: 25,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.colorScheme.primary.withOpacity(0.3),
                            border: Border.all(
                              color: theme.colorScheme.primary
                            )
                          ),
                          child: Center(
                            child: Text(
                              item.genreModel!.name,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSecondary,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                            border: Border.all(
                              color: theme.colorScheme.primary
                            )
                          ),
                          child: Center(
                            child: Text(
                              'D',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSecondary,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )  
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}