import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/config.dart';
import '/presentation/widgets/buttons.dart';
import '/utils/utils.dart';

import 'widgets/general_count.dart';
import 'widgets/genres_songs_count.dart';
import 'widgets/top_read_songs.dart';

class MetricsScreen extends StatelessWidget {
  const MetricsScreen({super.key});

  
  static const String routePath = 'metrics';

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lang.moreOptionsScreen_metrics,
          style: theme.textTheme.titleSmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
      ),
      body: const MetricsScreenUI(),
    );
  }
}

class MetricsScreenUI extends StatelessWidget {
  const MetricsScreenUI({super.key});

  @override
  Widget build(BuildContext context) {

    final lang = Lang.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: Sizes.kPadding * 2,
          ),
          _Section(
            text: lang.metricsScreen_generalCount, 
            content: const GeneralCount(),
          ),
          const SizedBox(
            height: Sizes.kPadding,
          ),
          _Section(
            text: lang.metricsScreen_topReadSongs, 
            content: const TopReadSongs(),
          ),
          const SizedBox(
            height: Sizes.kPadding * 2,
          ),
          _Section(
            text: lang.metricsScreen_topGenreWithMostSongs, 
            content: const GenresSongsCountChart(),
          ),
          const SizedBox(
            height: Sizes.kPadding,
          )
        ],
      ),
    );
  }
}



class _Section extends StatelessWidget {
  const _Section({
    required this.text,
    required this.content,
  });

  final String text;
  final Widget content;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInRight(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary
            ),
          ),
        ),
        const SizedBox(
          height: Sizes.kPadding,
        ),
        content
      ],
    );
  }
}