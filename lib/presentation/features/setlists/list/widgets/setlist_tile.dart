import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlist_songs/list/setlist_songs_list_screen.dart';
import '/presentation/features/setlists/list/providers/providers.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlists_route_params_model.dart';
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
    final lang = Lang.of(context);
    


    return ListTile(
      onTap: prov.isSelectItemOpened  && setlistModel.allowToRemoveBool
      ? ()=> prov.selectItem(id: setlistModel.id)
      : prov.isSelectItemOpened  && !setlistModel.allowToRemoveBool 
      ? null 
      : ()=> GoRouter.of(context).go(
        context.namedLocation(
          SetlistSongsListScreen.routeName,
          pathParameters: {
            'sid': setlistModel.id.toString()
          },
        ),
        extra: SetlistRouteParamsModel(
          setlistModel: setlistModel
        )
      ),
      onLongPress: prov.isSelectItemOpened 
      ? null 
      : ()=> prov.openCloseSelectItem(
        id: setlistModel.allowToRemoveBool ? setlistModel.id : null
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
          '${setlistModel.totalSongs} ${lang.setlistsListScreen_songs}',
          style: theme.textTheme.bodySmall,
        ),
      )
      : FadeInRight(
        duration: const Duration(milliseconds: 100),
        child: Text(
          '${setlistModel.totalSongs} ${lang.setlistsListScreen_songs}',
          style: theme.textTheme.bodySmall,
        ),
      ),
      trailing: !setlistModel.allowToRemoveBool ? 
      FadeInRight(
        duration: const Duration(milliseconds: 100),
        child: const Icon(CupertinoIcons.pin_fill),
      ) 
      : null,
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
        color: theme.colorScheme.tertiary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorScheme.tertiary
        ),
      ),
      child: setlistModel.allowToRemoveBool ?
      Center(
        child: Text(
          setlistModel.nameInitials,
          style: TextStyle(
            fontSize: 18,
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
    final lang = Lang.of(context);

    return Text(
      setlistModel.allowToRemoveBool ? setlistModel.name : lang.app_favorites,
      style: theme.textTheme.displaySmall,
    );
  }
}