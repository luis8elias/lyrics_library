import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/loaders.dart';
import '/services/metrics_service.dart';
import '/utils/utils.dart';

class TopReadSongs extends StatelessWidget {
  const TopReadSongs({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.displaySmall!.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 12
    );
    final metricsService = Injector.appInstance.get<MetricsService>();
    final lang = Lang.of(context);


    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.kPadding
      ),
      child: FutureBuilder(
        future: metricsService.topMostReadSongs(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const SizedBox(
              height: 200,
              child: LoadingWidget(),
            );
          }

          if(snapshot.data!.isFailed){
            return const Text('Error');
          }

          final resp = snapshot.data!.model!;
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: Sizes.kPadding,
                  bottom: Sizes.kPadding * 0.5
                ),
                child: FadeInRight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12
                          ),
                          child: Text(
                            lang.metricsScreen_topReadSongsReads,
                            style: titleStyle,
                          ),
                        )
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          lang.metricsScreen_topReadSongsSong,
                          style: titleStyle,
                        )
                      ),
                      Expanded(
                        child: Text(
                          lang.metricsScreen_topReadSongsGenre,
                          style: titleStyle,
                        )
                      )
                    ],
                  ),
                )
              ),
              Container(
                height: 0.5,
                color : theme.colorScheme.outline
              ),

              ...resp.map((mostReadSong) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TopReadSongRow(
                    views: mostReadSong.views,
                    title: mostReadSong.song,
                    genre: mostReadSong.genre!,
                  ),
                  Container(
                  height: 0.5,
                  color : theme.colorScheme.outline
                ),
                ],
              )).toList()
            ],
          );
        }
      ),
    );
  }
}


class _TopReadSongRow extends StatelessWidget {
  const _TopReadSongRow({
    required this.views,
    required this.genre,
    required this.title
  });

  final int views;
  final String title;
  final String genre;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return FadeInRight(
      child: Padding(
        padding: const  EdgeInsets.only(
          top: Sizes.kPadding,
          bottom: Sizes.kPadding * 0.5
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      border: Border.all(
                        color: theme.colorScheme.primary
                      ),
                    ),
                    child:  Center(
                      child: Text(
                        views.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                genre,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ),
    );
  }
}