import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/delete/providers/providers.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/snackbar/snackbar_helper.dart';
import '/utils/constants/sizes.dart';

class DeleteSongButton extends ConsumerWidget {
  const DeleteSongButton({
    super.key,
    required this.enabled
  });
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final theme = Theme.of(context);

    return  SendProviderListener(
      provider: deleteSongProvider,
      onError: (error) => SnackbarHelper.show(
        context: context,
        message: error
      ),
      onSuccess: (model, message) {
        ref.read(songsListProvider).deleteSongs();
      },
      child: SendProviderBuilder(
        provider: deleteSongProvider,
        loaderWidget: BasicTextButton(
          onPressed: null,
          buildChild: (loadingChild) => loadingChild,
          text: lang.actions_delete
        ),
        child: TextButton(
          onPressed: enabled 
          ? (){
            showModalBottomSheet(
              enableDrag: false,
              context: context, 
              builder: (context) => const _DeleteSongsBottomSheet()
            );
          }
          : null,
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error
          ),
          child: Text(
            lang.actions_delete,
          )
        ),
      ),
    );
  }
}


class _DeleteSongsBottomSheet extends ConsumerWidget {
  const _DeleteSongsBottomSheet();

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final prov = ref.read(songsListProvider);
    final deleteSongsProv = ref.read(deleteSongProvider);
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
                  ? lang.songsDelete_title
                  : lang.songsDelete_titlePlural,
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
                      songsIds: prov.selectedItems
                    );
                  },
                  trailing: Icon(
                    CupertinoIcons.delete,
                    color: theme.colorScheme.error,
                  ),
                  title: prov.selectedItems.length == 1 
                  ? Text(
                    lang.songsDelete_deleteButton,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  )
                  : Text(
                    lang.songsDelete_deleteButtonPlural(prov.selectedItems.length),
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