import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/more/scan_song/providers/providers.dart';
import '/presentation/features/more/scan_song/providers/scan_song_provider.dart';
import '/presentation/features/more/scan_song/widgets/on_loading_scan.dart';
import '/presentation/widgets/buttons.dart';
import '/utils/snackbar/snackbar_helper.dart';
import 'widgets/on_find_song.dart';

class ScanSongScreen extends StatelessWidget {
  const ScanSongScreen({super.key});

  static const String routePath = 'scan-song';

  @override
  Widget build(BuildContext context) {

    final lang = Lang.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lang.scanSong_title,
          style: theme.textTheme.titleSmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
      ),
      body: const ScanSongScreenBuilder(),
    );
  }
}

class ScanSongScreenBuilder extends ConsumerWidget {
  const ScanSongScreenBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    
    final reactiveProv = ref.watch(scanSongProvider);
    final lang = Lang.of(context);


    if(reactiveProv.scanSatate == ScanSongState.findSong){
      return OnFindSong(
        scannedSongModel: reactiveProv.scannedSong!,
      );
    }

    if(reactiveProv.scanSatate == ScanSongState.failed){
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
        SnackbarHelper.show(
          context: context, 
          message: lang.scanSong_invalidQr
        );
      });
    }
    
    return const OnLoadingScan();

    
  }
}