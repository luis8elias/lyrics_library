  
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/genres/edit/providers/providers.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';

class EditGenreButton extends ConsumerWidget {
  const EditGenreButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final provider = ref.watch(editGenreProvider);
    final lang = Lang.of(context);

    return SendProviderBuilder(
      provider: editGenreProvider,
      loaderWidget: BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.genresEditScreen_editButtonText
      ),
      child: BasicButton(
        onPressed: provider.isFormValid ?
        () => provider.editGenre() 
        : null, 
        text: lang.genresEditScreen_editButtonText
      ),
    );
  }
}