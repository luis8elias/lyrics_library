import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/providers/send_provider.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';

class SaveSongButton extends StatelessWidget {
  const SaveSongButton({
    super.key,
    required this.providerListenable,
    required this.onPressed
  });

  final ProviderListenable<SendProvider> providerListenable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    
    return SendProviderBuilder(
      provider: providerListenable,
      loaderWidget: BasicTextButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.actions_delete
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          lang.actions_save,
        )
      ),
    );
  }
}