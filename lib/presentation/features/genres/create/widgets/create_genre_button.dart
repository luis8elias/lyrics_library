  
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/create/providers/proivders.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';

class CreateGenreButton extends ConsumerWidget {
  const CreateGenreButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final provider = ref.watch(createGenreProvider);
    final lang = Lang.of(context);

    return SendProviderBuilder(
      provider: createGenreProvider,
      loaderWidget: BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.genresCreateScreen_createButtonText
      ),
      child: BasicButton(
        onPressed: provider.isFormValid ?
        () => provider.createGenre() 
        : null, 
        text: lang.genresCreateScreen_createButtonText
      ),
    );
  }
}