import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/widgets/buttons.dart';

class ReadSetlistScreen extends ConsumerWidget {
  const ReadSetlistScreen({
    super.key,
    required this.setlistModel
  });

  final SetlistModel setlistModel;

  static const String routeName = 'read-setlist';
  static const String routePath = ':sid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Sizes.kPadding / 2,
            ),
            child: CreateButton(
              onPressed: (){}
            ),
          ),
        ], 
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        title: Column(
          children: [
            Text(
              setlistModel.allowToRemoveBool ? setlistModel.name : lang.app_favorites,
              style: theme.textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.primary.withOpacity(0.3),
                border: Border.all(
                  color: theme.colorScheme.primary
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: Platform.isIOS ? 0: 2
                  ),
                  child: Text(
                    lang.app_setlist,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 8
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kPadding
            ),
            width: double.infinity,
            color: theme.colorScheme.inverseSurface.withOpacity(0.5),
             child: Text(
              '0 ${lang.app_items}',
              style: theme.textTheme.bodySmall,
            ),
            // child: Text(
            //   reactiveProv.isSelectItemOpened 
            //   ? '${reactiveProv.selectedItems.length} ${lang.app_selectedItems}'
            //   : reactiveProv.isModelInitialized ?
            //    '${reactiveProv.model!.length  } ${lang.app_items}'
            //    : '0 ${lang.app_items}',
            //   style: theme.textTheme.bodySmall,
            // ),
          ),
          const Expanded(
            child: Placeholder(),
          )
        ],
      ),
    );
  }
}