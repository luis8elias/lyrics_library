  
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/edit/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';

class EditSetlistButton extends ConsumerWidget {
  const EditSetlistButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final provider = ref.watch(editSetlistProvider);
    final lang = Lang.of(context);

    return SendProviderBuilder(
      provider: editSetlistProvider,
      loaderWidget: BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.actions_edit
      ),
      child: BasicButton(
        onPressed: provider.isFormValid ?
        () => provider.editSetlist() 
        : null, 
        text: lang.actions_edit
      ),
    );
  }
}