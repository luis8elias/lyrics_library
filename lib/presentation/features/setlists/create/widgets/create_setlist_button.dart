  
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/create/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';

class CreateSetlistButton extends ConsumerWidget {
  const CreateSetlistButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final provider = ref.watch(createSetlistProvider);
    final lang = Lang.of(context);

    return SendProviderBuilder(
      provider: createSetlistProvider,
      loaderWidget: BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.setlistsCreateScreen_createButtonText
      ),
      child: BasicButton(
        onPressed: provider.isFormValid ?
        () => provider.createSetlist() 
        : null, 
        text: lang.setlistsCreateScreen_createButtonText
      ),
    );
  }
}