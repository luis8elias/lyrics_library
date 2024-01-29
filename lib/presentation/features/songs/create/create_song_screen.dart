import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/shared/widgets/save_song_button.dart';

import '/presentation/features/songs/create/providers/providers.dart';
import '/presentation/widgets/providers.dart';
import '/utils/snackbar/snackbar_helper.dart';
import '/presentation/features/songs/shared/widgets/song_form.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/buttons.dart';

class CreateSongScreen extends ConsumerWidget {
  const CreateSongScreen({super.key});

  static const String routeName = 'create-song';
  static const String routePath = 'create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  PopScope(
      canPop: true,
      onPopInvoked: (canPop) async {
        ref.read(createSongProvider).resetFormModel();
      },
      child: SendProviderListener(
        provider: createSongProvider,
        onError: (error) => SnackbarHelper.show(context,error),
        onSuccess: (model, message) async{
          GoRouter.of(context).pop();
          ref.read(songsListProvider).refresh();
        },
        child: const _CreateSongScreenUI()
      ),
    );
  }
  
}

class _CreateSongScreenUI extends ConsumerWidget {
  const _CreateSongScreenUI();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final reactiveProv = ref.watch(createSongProvider);
    final prov = ref.read(createSongProvider);
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            SaveSongButton(
              onPressed:  reactiveProv.isFormValid ? prov.createSong : null,
              providerListenable: createSongProvider,
            ),
          ],
          leading: BackButtonWidget(
            onPressed: () {
              prov.resetFormModel();
              GoRouter.of(context).pop();
            },
          ),
          title: Text(
            lang.songsCreateScreen_title,
            style: theme.textTheme.titleSmall,
          ),
        ),
        body: SongForm(
          titleInputLabel: lang.songsCreateScreen_titleInput,
          lyricsInputLabel: lang.songsCreateScreen_lyricInput,
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