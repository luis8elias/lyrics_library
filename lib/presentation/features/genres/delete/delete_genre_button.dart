import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyrics_library/presentation/widgets/buttons.dart';
import 'package:lyrics_library/presentation/widgets/providers.dart';
import 'package:lyrics_library/utils/snackbar/snackbar_helper.dart';

import '/presentation/features/genres/delete/providers/providers.dart';
import '/presentation/features/genres/list/providers/providers.dart';
import '/utils/constants/sizes.dart';

class DeleteGenreButton extends ConsumerWidget {
  const DeleteGenreButton({
    super.key,
    required this.onPressed
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);

    return  SendProviderListener(
      provider: deleteGenreProvider,
      onError: (error) => SnackbarHelper.show(context, error),
      onSuccess: (model, message) {
        ref.read(genresListProvider).deleteGenres();
        SnackbarHelper.show(context, message);
      },
      child: SendProviderBuilder(
        provider: deleteGenreProvider,
        loaderWidget: BasicTextButton(
          onPressed: null,
          buildChild: (loadingChild) => loadingChild,
          text:'Eliminar'
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error
          ),
          onPressed: onPressed != null 
          ? (){
            onPressed!();
            showModalBottomSheet(
              enableDrag: false,
              context: context, 
              builder: (context) => const GenresOptionsBottomSheet()
            );
          }
          : null,
          child: const Text(
            'Eliminar',
          )
        ),
      ),
    );
  }
}


class GenresOptionsBottomSheet extends ConsumerWidget {
  const GenresOptionsBottomSheet({
    super.key,
  });

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final prov = ref.read(genresListProvider);
    final deleteGenresProv = ref.read(deleteGenreProvider);

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
                  prov.selectedGenres.length == 1 
                  ? '¿Eliminar género?'
                  : '¿Eliminar géneros?',
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
                      genresIds: prov.selectedGenres
                    );
                  },
                  trailing: Icon(
                    CupertinoIcons.delete,
                    color: theme.colorScheme.error,
                  ),
                  title: prov.selectedGenres.length == 1 
                  ? Text(
                  'Eliminar género',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  )
                  : Text(
                    'Eliminar ${prov.selectedGenres.length} géneros',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ),
              Container(
                color: theme.colorScheme.background,
                child: Divider(
                  color: theme.colorScheme.outline,
                  thickness: 0.5,
                ),
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
                    'Cancelar',
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