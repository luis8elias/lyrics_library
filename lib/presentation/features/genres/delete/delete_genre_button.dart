import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/snackbar/snackbar_helper.dart';
import '/presentation/features/genres/delete/providers/providers.dart';
import '/presentation/features/genres/list/providers/providers.dart';
import '/utils/constants/sizes.dart';

class DeleteGenreButton extends ConsumerWidget {
  const DeleteGenreButton({
    super.key,
    required this.enabled
  });
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final theme = Theme.of(context);

    return  SendProviderListener(
      provider: deleteGenreProvider,
      onError: (error) => SnackbarHelper.show(
        context: context,
        message: error
      ),
      onSuccess: (model, message) {
        ref.read(genresListProvider).deleteGenres();
        //SnackbarHelper.show(context, message);
      },
      child: SendProviderBuilder(
        provider: deleteGenreProvider,
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
              builder: (context) => const DeleteGenresBottomSheet()
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


class DeleteGenresBottomSheet extends ConsumerWidget {
  const DeleteGenresBottomSheet({
    super.key,
  });

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final prov = ref.read(genresListProvider);
    final deleteGenresProv = ref.read(deleteGenreProvider);
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
                  ? lang.genresDelete_title
                  : lang.genresDelete_titlePlural,
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
                    deleteGenresProv.deleteGenres(
                      genresIds: prov.selectedItems
                    );
                  },
                  trailing: Icon(
                    CupertinoIcons.delete,
                    color: theme.colorScheme.error,
                  ),
                  title: prov.selectedItems.length == 1 
                  ? Text(
                    lang.genresDelete_deleteButton,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  )
                  : Text(
                    lang.genresDelete_deleteButtonPlural(prov.selectedItems.length),
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