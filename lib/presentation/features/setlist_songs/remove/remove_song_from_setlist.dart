import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyrics_library/presentation/features/setlists/list/providers/providers.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlist_songs/list/provider/providers.dart';
import '/presentation/features/setlist_songs/remove/providers/providers.dart';
import '/presentation/features/songs/delete/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/constants/sizes.dart';
import '/utils/snackbar/snackbar_helper.dart';

class RemoveSongsFromSetlistButton extends ConsumerWidget {
  const RemoveSongsFromSetlistButton({
    super.key,
    required this.enabled,
    required  this.setlistId
  });
  final bool enabled;
  final Guid setlistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final theme = Theme.of(context);
    final ssListProv =  ref.read(setlistSongsListProvider);

    return  SendProviderListener(
      provider: removeSongsFromSetlistProvider,
      onError: (error) => SnackbarHelper.show(
        context: context,
        message: error
      ),
      onSuccess: (model, message) {
        final count = ssListProv.selectedItems.length;
        ssListProv.deleteSongs();
        ref.read(setlistsListProvider).decrementSetlistTotalSongsCount(
          setlistId,
          count
        );
      },
      child: SendProviderBuilder(
        provider: deleteSongProvider,
        loaderWidget: BasicTextButton(
          onPressed: null,
          buildChild: (loadingChild) => loadingChild,
          text: lang.actions_remove
        ),
        child: TextButton(
          onPressed: enabled 
          ? (){
            showModalBottomSheet(
              enableDrag: false,
              context: context, 
              builder: (context) => _DeleteSongsBottomSheet(
                setlistId: setlistId,
              )
            );
          }
          : null,
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error
          ),
          child: Text(
            lang.actions_remove,
          )
        ),
      ),
    );
  }
}


class _DeleteSongsBottomSheet extends ConsumerWidget {
  const _DeleteSongsBottomSheet({
    required this.setlistId
  });

  final Guid setlistId;

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final prov = ref.read(setlistSongsListProvider);
    final deleteSongsProv = ref.read(removeSongsFromSetlistProvider);
    final lang = Lang.of(context);

    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.kBorderRadius),
            topRight: Radius.circular(Sizes.kBorderRadius)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.kPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: Sizes.kPadding,
                  bottom: Sizes.kPadding
                ),
                child: Text(
                  prov.selectedItems.length == 1 
                  ? lang.setlistSongsRemove_title
                  : lang.setlistSongsRemove_titlePlural,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Material(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Sizes.kBorderRadius),
                  topRight: Radius.circular(Sizes.kBorderRadius),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)
                ),
                color: theme.colorScheme.background,
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.kBorderRadius),
                      topRight: Radius.circular(Sizes.kBorderRadius),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)
                    ),
                  ),
                  minLeadingWidth: 25,
                  onTap: (){
                    Navigator.of(context).pop();
                    deleteSongsProv.deleteSongs(
                      songsIds: prov.selectedItems,
                      setlistId: setlistId
                    );
                  },
                  trailing: Icon(
                    CupertinoIcons.delete,
                    color: theme.colorScheme.error,
                  ),
                  title: prov.selectedItems.length == 1 
                  ? Text(
                    lang.setlistSongsRemove_removeButton,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  )
                  : Text(
                    lang.setlistSongsRemove_removeButtonPlural(prov.selectedItems.length),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color : theme.colorScheme.outline
              ),
              Material(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(Sizes.kBorderRadius),
                  bottomRight: Radius.circular(Sizes.kBorderRadius)
                ),
                color: theme.colorScheme.background,
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(Sizes.kBorderRadius),
                      bottomRight: Radius.circular(Sizes.kBorderRadius)
                    ),
                  ),
                  minLeadingWidth: 25,
                  onTap: () => Navigator.of(context).pop(),
                  trailing: Icon(
                    CupertinoIcons.clear_circled,
                    color: theme.colorScheme.onBackground,
                  ),
                  title: Text(
                    lang.actions_cancel,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onBackground
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: Sizes.kPadding * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}