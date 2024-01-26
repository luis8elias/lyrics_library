import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lyrics_library/presentation/features/setlists/edit/widgets/edit_setlist_button.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/edit/providers/providers.dart';
import '/presentation/features/setlists/list/providers/providers.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/features/setlists/shared/widgets/genre_from.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/constants/sizes.dart';
import '/utils/snackbar/snackbar_helper.dart';

class EditSetlistScreen extends ConsumerStatefulWidget {
  const EditSetlistScreen({
    super.key,
    required this.setlistModel
  });

  final SetlistModel setlistModel;

  static const String routeName = 'edit-setlist';
  static const String routePath = 'edit/:sid';

  @override
  ConsumerState<EditSetlistScreen> createState() => _EditSetlistScreenState();
}

class _EditSetlistScreenState extends ConsumerState<EditSetlistScreen> {

  @override
  void initState() {
    ref.read(editSetlistProvider).initFormModel(setlistModel: widget.setlistModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: true,
      onPopInvoked: (value)  {
        ref.read(editSetlistProvider).resetFormModel();
      },
      child: SendProviderListener(
        provider: editSetlistProvider,
        onError: (error) => SnackbarHelper.show(context,error),
        onSuccess: (model, message) async{
          GoRouter.of(context).pop();
          //SnackbarHelper.show(context,message);
          ref.read(setlistsListProvider).editSetlist(model);
        },
        child: _EditSetlistScreenUI(
          setlistModel: widget.setlistModel,
        )
      ),
    );
  }
}

class _EditSetlistScreenUI extends ConsumerWidget {
  const _EditSetlistScreenUI({required this.setlistModel});

  final SetlistModel setlistModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final prov = ref.read(editSetlistProvider);
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          lang.setlistsEditScreen_title,
          style: theme.textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.kPadding
        ),
        child: SetlistForm(
          setlistModel: setlistModel,
          actionButton: const EditSetlistButton(),
          onNameChanged: (name) => prov.updateFormModel((formModel) => formModel.copyWith(
            name: name
          )),
        ),
      ),
    );
  }
}