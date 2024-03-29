import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/shared/widgets/save_song_button.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/edit/providers/providers.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/features/songs/shared/widgets/song_form.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/snackbar/snackbar_helper.dart';

class EditSongScreen extends ConsumerStatefulWidget {
  const EditSongScreen({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  static const String routeName = 'edit-song';
  static const String routePath = 'edit/:sid';

  @override
  ConsumerState<EditSongScreen> createState() => _EditSongScreenState();
}

class _EditSongScreenState extends ConsumerState<EditSongScreen> {

  @override
  void initState() {
    ref.read(editSongProvider).initFormModel(songModel: widget.songModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: true,
      onPopInvoked: (value)  {
        ref.read(editSongProvider).resetFormModel();
      },
      child: SendProviderListener(
        provider: editSongProvider,
        onError: (error) => SnackbarHelper.show(
          context: context,
          message: error
        ),
        onSuccess: (model, message) async{
          GoRouter.of(context).pop();
          //SnackbarHelper.show(context,message);
          ref.read(songsListProvider).editSong(model);
        },
        child: _EditGenreScreenUI(
          songModel: widget.songModel,
        )
      ),
    );
  }
}

class _EditGenreScreenUI extends ConsumerWidget {
  const _EditGenreScreenUI({required this.songModel});

  final SongModel songModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final reactiveProv = ref.watch(editSongProvider);
    final prov = ref.read(editSongProvider);
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            SaveSongButton(
              onPressed:  reactiveProv.isFormValid ? prov.editGenre : null,
              providerListenable: editSongProvider,
            ),
          ], 
          leading: BackButtonWidget(
            onPressed: () {
              prov.resetFormModel();
              GoRouter.of(context).pop();
            },
          ), 
          title: Text(
            lang.songsEditScreen_title,
            style: theme.textTheme.titleSmall,
          ),
        ),
        body: SongForm(
          songModel: songModel,
          titleInputLabel: lang.songsEditScreen_titleInput,
          lyricsInputLabel: lang.songsEditScreen_lyricInput,
          onTitleChanged: (value) => prov.updateFormModel((formModel) => formModel.copyWith(
            title: value
          )),
          onLyricChanged: (value) => prov.updateFormModel((formModel) => formModel.copyWith(
            lyric: value
          )),
          onGenreChanged: (value) => prov.updateFormModel((formModel) => formModel.copyWith(
            genre: value
          )),
        ),
      ),
    );
  }
}