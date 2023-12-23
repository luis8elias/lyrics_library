import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/presentation/widgets/screen_scaffold.dart';
import '/presentation/widgets/transparent_appbar.dart';
import '/utils/constants/sizes.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/edit/providers/providers.dart';
import '/presentation/features/genres/edit/widgets/edit_genre_button.dart';
import '/presentation/features/genres/list/providers/providers.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/features/genres/shared/widgets/genre_from.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/snackbar/snackbar_helper.dart';

class EditGenreScreen extends ConsumerStatefulWidget {
  const EditGenreScreen({
    super.key,
    required this.genreModel
  });

  final GenreModel genreModel;

  static const String routeName = 'edit-genre';
  static const String routePath = 'edit/:gid';

  @override
  ConsumerState<EditGenreScreen> createState() => _EditGenreScreenState();
}

class _EditGenreScreenState extends ConsumerState<EditGenreScreen> {

  @override
  void initState() {
    ref.read(editGenreProvider).initFormModel(genreModel: widget.genreModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: true,
      onPopInvoked: (value)  {
        ref.read(editGenreProvider).resetFormModel();
      },
      child: SendProviderListener(
        provider: editGenreProvider,
        onError: (error) => SnackbarHelper.show(context,error),
        onSuccess: (model, message) async{
          GoRouter.of(context).pop();
          //SnackbarHelper.show(context,message);
          ref.read(genresListProvider).editGenre(model);
        },
        child: _EditGenreScreenUI(
          genreModel: widget.genreModel,
        )
      ),
    );
  }
}

class _EditGenreScreenUI extends ConsumerWidget {
  const _EditGenreScreenUI({required this.genreModel});

  final GenreModel genreModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final prov = ref.read(editGenreProvider);
    
    return ScreenScaffold(
      appBar: CustomAppBar(
        actions: const[], 
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              //prov.resetFormModel();
              GoRouter.of(context).pop();
            },
          )
        ),
        title: lang.genresEditScreen_title
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.kAppBarSize + 5
        ),
        child: GenreForm(
          genreModel: genreModel,
          actionButton: const EditGenreButton(),
          onNameChanged: (name) => prov.updateFormModel((formModel) => formModel.copyWith(
            name: name
          )),
        ),
      ),
    );
  }
}