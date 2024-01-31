import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/shared/widgets/genre_from.dart';
import '/presentation/features/setlists/create/widgets/create_setlist_button.dart';
import '/presentation/features/setlists/list/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/utils.dart';
import 'providers/providers.dart';

class CreateSetlistScreen extends ConsumerWidget {
  const CreateSetlistScreen({super.key});

  static const String routeName = 'create-setlist';
  static const String routePath = 'create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  PopScope(
      canPop: true,
      onPopInvoked: (canPop) async {
        ref.read(createSetlistProvider).resetFormModel();
      },
      child: SendProviderListener(
        provider: createSetlistProvider,
        onError: (error) => SnackbarHelper.show(
          context: context,
          message: error
        ),
        onSuccess: (model, message) async{
          GoRouter.of(context).pop();
          //SnackbarHelper.show(context,message);
          ref.read(setlistsListProvider).addSetlist(
            setlistModel: model!
          );
        },
        child: const _CreateSetlistScreenUI()
      ),
    );
  }
}

class _CreateSetlistScreenUI extends ConsumerWidget {
  const _CreateSetlistScreenUI();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.read(createSetlistProvider);
    final lang = Lang.of(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: const[], 
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackButtonWidget(
              onPressed: () {
                prov.resetFormModel();
                GoRouter.of(context).pop();
              },
            ),
          ), 
          title: Text(
            lang.setlistsCreateScreen_title,
            style: theme.textTheme.titleSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.kPadding
          ),
          child: GenreForm(
            actionButton: const CreateSetlistButton(),
            onNameChanged: (name) => prov.updateFormModel(
              (formModel) => formModel.copyWith( name: name),
            ),
          ),
        ),
      ),
    );
  }
}