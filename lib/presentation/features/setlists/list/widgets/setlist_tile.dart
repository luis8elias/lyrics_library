import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/setlists/list/providers/providers.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/utils/constants/sizes.dart';

class SetlistTile extends ConsumerWidget {
  const SetlistTile({
    super.key,
    required this.setlistModel
  });

  final SetlistModel setlistModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.read(setlistsListProvider);
    final reactiveProv = ref.watch(setlistsListProvider);
    final theme = Theme.of(context);
    


    return ListTile(
      onTap: prov.isSelectItemOpened  && setlistModel.allowToRemoveBool
      ? ()=> prov.selectItem(id: setlistModel.id) : (){},
      // : ()=> GoRouter.of(context).go(
      //   context.namedLocation(
      //     EditSetlistScreen.routeName,
      //     pathParameters: {
      //       'sid': setlistModel.id.toString()
      //     },
      //   ),
      //   extra: setlistModel
      // ),
      onLongPress: prov.isSelectItemOpened 
      ? null 
      : ()=> prov.openCloseSelectItem(
        id: setlistModel.id
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.kPadding,
        vertical: Sizes.kPadding * 0.2,
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          if(reactiveProv.isSelectItemOpened)
          FadeInLeft(
            duration: const Duration(milliseconds: 100),
            child: Visibility(
              visible: setlistModel.allowToRemoveBool,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: CupertinoCheckbox(
                checkColor: theme.colorScheme.onPrimary,
                activeColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                ),
                value: setlistModel.allowToRemoveBool ?
                reactiveProv.selectedItems.contains(setlistModel.id)
                : false, 
                onChanged: (value){
                  if(setlistModel.allowToRemoveBool){
                    prov.selectItem(
                      id: setlistModel.id
                    );
                  }
                },
              ),
            ),
          ),
          if(reactiveProv.isSelectItemOpened)
          const SizedBox(
            width: Sizes.kPadding,
          ),

          reactiveProv.isSelectItemOpened 
          ? FadeInLeft(
            duration: const Duration(milliseconds: 100),
            child: _SetlistTileLeading(
              setlistModel: setlistModel,
            ),
          )
          : FadeInRight(
            duration: const Duration(milliseconds: 100),
            child: _SetlistTileLeading(
              setlistModel: setlistModel,
            ),
          ),
        ],
      ),
      title: reactiveProv.isSelectItemOpened 
      ? FadeInLeft(
        duration: const Duration(milliseconds: 100),
        child: _SetlistTileTitle(
          setlistModel: setlistModel,
        )
      )
      : FadeInRight(
        duration: const Duration(milliseconds: 100),
        child: _SetlistTileTitle(
          setlistModel: setlistModel,
        )
      ) ,
      subtitle: reactiveProv.isSelectItemOpened 
      ? FadeInLeft(
        duration: const Duration(milliseconds: 100),
        child: Text(
          '13 songs',
          style: theme.textTheme.bodySmall,
        ),
      )
      : FadeInRight(
        duration: const Duration(milliseconds: 100),
        child: Text(
          '13 songs',
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}


class _SetlistTileLeading extends StatelessWidget {
  const _SetlistTileLeading({
    required this.setlistModel
  });

  final SetlistModel setlistModel;

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
      child: setlistModel.allowToRemoveBool ?
      Center(
        child: Text(
          setlistModel.name[0].toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: theme.colorScheme.onBackground,
            fontWeight: FontWeight.bold
          ),
        ),
      )
      : Icon(
        CupertinoIcons.heart_fill,
        size: 20,
        color: theme.colorScheme.onBackground,
      ),
    );
  }
}

class _SetlistTileTitle extends StatelessWidget {
  const _SetlistTileTitle({
    required this.setlistModel
  });

  final SetlistModel setlistModel;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Text(
      setlistModel.allowToRemoveBool ? setlistModel.name : 'Favorites',
      style: theme.textTheme.displaySmall,
    );
  }
}