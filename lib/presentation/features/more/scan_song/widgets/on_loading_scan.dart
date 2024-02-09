import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../providers/providers.dart';
import '/config/config.dart';
import '/presentation/widgets/loaders.dart';
import '/utils/constants/sizes.dart';

class OnLoadingScan extends ConsumerStatefulWidget {
  const OnLoadingScan({super.key});
  
  

  @override
  ConsumerState<OnLoadingScan> createState() => _OnLoadingScanState();
}

class _OnLoadingScanState extends ConsumerState<OnLoadingScan> {

  late MobileScannerController scannerController;

  @override
  void initState() {
    scannerController = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: true,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }


@override
  Widget build(BuildContext context) {

    final lang = Lang.of(context);
    final prov = ref.read(scanSongProvider);

    return  Column(
      children: [
        Expanded(
          child: MobileScanner(
            controller: scannerController,
            onDetect: (value) {
              prov.onDetectSong(value.barcodes[0].rawValue);
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kPadding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  lang.scanSong_laoding,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: Sizes.kPadding * 2,
                ),
                const CleanLoaderWidget()
              ],
            ),
          ),
        ),
      ],
    );
  }
}