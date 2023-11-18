import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

    return  Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 1,
        scaffoldKey: key,
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => prov.songsController.refresh(),
          ),
          child: PagedListView<int, String>.separated(
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.09,
            ),
            pagingController: prov.songsController,
            builderDelegate: PagedChildBuilderDelegate<String>(
              firstPageProgressIndicatorBuilder: (context) => const LoadingScreen(),
              newPageProgressIndicatorBuilder: (context) => Padding(
                padding:  EdgeInsets.only(
                  top: 20,
                  bottom: Sizes.kBottomNavHeight + 30
                ),
                child: const LoadingWidget(),
              ),
              itemBuilder: (context, item, index) {
                return Padding(
                padding: EdgeInsets.only(
                  //Comparar con totalSongs
                  bottom: (index+1) == 55 ? 70 : 0.0
                ),
                child: ListTile(
                  title: Text(
                    item,
                    style: theme.textTheme.titleSmall,
                  ),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
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
                              'Cumbia',
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