import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/presentation.dart';
import '/services/metrics_service.dart';
import '/utils/constants/sizes.dart';

class GeneralCount extends StatelessWidget {
  const GeneralCount({super.key});

  @override
  Widget build(BuildContext context) {

    final metricsService = Injector.appInstance.get<MetricsService>();
    final lang = Lang.of(context);

    return Padding(
      padding: const EdgeInsets.all(
        Sizes.kPadding
      ),
      child: FutureBuilder(
        future: metricsService.getGeneralCount(),
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
            children: [
              Row(
                children: [
                  _GeneralCountItem(
                    title: lang.app_songs,
                    value: resp.totalSongs,
                    icon: CupertinoIcons.music_note,
                  ),
                ],
              ),
              const SizedBox(
                height: Sizes.kPadding * 0.5,
              ),
              Row(
                children: [
                  _GeneralCountItem(
                    title: lang.app_genres,
                    value: resp.totalGenres,
                    icon: CupertinoIcons.collections,
                  ),
                  const SizedBox(
                    width: Sizes.kPadding * 0.5,
                  ),
                  _GeneralCountItem(
                    title: lang.app_setlists,
                    value: resp.totalSetlists,
                    icon: CupertinoIcons.music_note_list,
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }
}


class _GeneralCountItem extends StatelessWidget {
  const _GeneralCountItem({
    required this.icon,
    required this.title,
    required this.value
  });

  final String title;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Expanded(
      child: FadeInRight(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: theme.appBarTheme.backgroundColor,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: Sizes.kPadding,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 1
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                width: Sizes.kPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.toString(),
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground
                    ),
                  ),
                  Text(title)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}