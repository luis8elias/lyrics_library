import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/search_input.dart';
import '/utils/constants/sizes.dart';
import '/utils/snackbar/snackbar_helper.dart';

class AddToSetlistBottomSheet extends ConsumerStatefulWidget {
  const AddToSetlistBottomSheet({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  @override
  ConsumerState<AddToSetlistBottomSheet> createState() => _AddToSetlistBottomSheetState();
}

class _AddToSetlistBottomSheetState extends ConsumerState<AddToSetlistBottomSheet> {

  @override
  void initState() {
    final prov = ref.read(addToSetlistListProvider);
    prov.setSongId(widget.songModel.id);
    prov.setInitialIsFavorite(widget.songModel.isFavoriteAsBool);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      prov.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final prov = ref.read(addToSetlistListProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Sizes.kBorderRadius),
              topRight: Radius.circular(Sizes.kBorderRadius)
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Sizes.kPadding * 0.3,
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                            width: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5
                            ),
                            child: Text(
                              lang.songsListScreen_addToSetlistTitle,
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          IconButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                            icon:  Icon(
                              CupertinoIcons.xmark_circle_fill,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.kPadding,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.kPadding
                      ),
                      child: SearchInput(
                        onChangeSearch: (query) => {
                          prov.updateQuery(query)
                        },
                        autoFocus: false,
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                    Expanded(
                      child: FetchProviderBuilder(
                        provider: addToSetlistListProvider,
                        builder:(setlists) {
                          return ListView.builder(
                          itemCount: setlists!.length,
                          itemBuilder: (context, index) {
                            final setlist = setlists[index];
                            return _SetlistTile(setlistModel: setlist);
                          },
                        );
                        }
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kPadding
                ),
                child: SendProviderListener(
                  provider: addToSetlistProvider,
                  onError: (error) => SnackbarHelper.show(context: context, message: error),
                  onSuccess: (model, message) {
                    GoRouter.of(context).pop();
                    SnackbarHelper.show(context: context, message: message);
                    ref.read(songsListProvider).setIsFavoriteSong(
                      songId: prov.songId, 
                      isFavorite: prov.isFavorite ?? prov.initialIsFavorite
                    );
                  },
                  child: BasicButton(
                    onPressed: (){
                      ref.read(addToSetlistProvider).saveSongInSetlists(
                        setlistIds: prov.selectedItems,
                        prevSelectedIds: prov.prevSelectedItems,
                        songId: prov.songId
                      );
                    }, 
                    text: lang.actions_ok
                  ),
                ),
              ),
              const SizedBox(
                height: Sizes.kPadding * 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _SetlistTile extends ConsumerWidget {
  const _SetlistTile({
    required this.setlistModel
  });

  final SetlistModel setlistModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.read(addToSetlistListProvider);
    final reactiveProv = ref.watch(addToSetlistListProvider);
    final theme = Theme.of(context);

    return ListTile(
      onTap: ()=> prov.selectItem(id: setlistModel.id),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.kPadding,
        vertical: Sizes.kPadding * 0.2,
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 100),
            child: CupertinoCheckbox(
              checkColor: theme.colorScheme.onPrimary,
              activeColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
              ),
              value: reactiveProv.selectedItems.contains(setlistModel.id),
              onChanged: (value){


                if(!setlistModel.allowToRemoveBool){
                  prov.setIsFavorite(value!);
                }

                prov.selectItem(
                  id: setlistModel.id
                );
              },
            ),
          ),
          const SizedBox(
            width: Sizes.kPadding,
          ),
          FadeInLeft(
            duration: const Duration(milliseconds: 100),
            child: _SetlistTileLeading(
              setlistModel: setlistModel,
            ),
          )
        ],
      ),
      title: FadeInLeft(
        duration: const Duration(milliseconds: 100),
        child: _SetlistTileTitle(
          setlistModel: setlistModel,
        )
      ),
     
      subtitle:  FadeInLeft(
        duration: const Duration(milliseconds: 100),
        child: Text(
          '${setlistModel.totalSongs} songs',
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
        color: theme.colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: theme.colorScheme.primary
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