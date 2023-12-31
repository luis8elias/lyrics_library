import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/presentation/widgets/screen_scaffold.dart';
import '/presentation/widgets/transparent_appbar.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/create/providers/providers.dart';
import '/presentation/features/genres/create/widgets/create_genre_button.dart';
import '/presentation/features/genres/list/providers/providers.dart';
import '/presentation/features/genres/shared/widgets/genre_from.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/utils.dart';

class CreateGenreScreen extends ConsumerWidget {
  const CreateGenreScreen({super.key});

  static const String routeName = 'create-genre';
  static const String routePath = 'create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  PopScope(
      canPop: true,
      onPopInvoked: (canPop) async {
        ref.read(createGenreProvider).resetFormModel();
      },
      child: SendProviderListener(
        provider: createGenreProvider,
        onError: (error) => SnackbarHelper.show(context,error),
        onSuccess: (model, message) async{
          GoRouter.of(context).pop();
          //SnackbarHelper.show(context,message);
          ref.read(genresListProvider).addGenre(genreModel: model!);
        },
        child: const _CreateGenreScreenUI()
      ),
    );
  }
}

class _CreateGenreScreenUI extends ConsumerWidget {
  const _CreateGenreScreenUI();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.read(createGenreProvider);
    final lang = Lang.of(context);

   

    return ScreenScaffold(
      appBar: CustomAppBar(
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
        title: lang.genresCreateScreen_title
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.kAppBarSize + 5
        ),
        child: GenreForm(
          actionButton: const CreateGenreButton(),
          onNameChanged: (name) => prov.updateFormModel(
            (formModel) => formModel.copyWith( name: name),
          ),
        ),
      ),
    );
  }
}