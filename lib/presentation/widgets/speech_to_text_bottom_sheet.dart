import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '/utils/utils.dart';
import '/config/lang/generated/l10n.dart';
import '/utils/constants/sizes.dart';

class SpeechToTextBottomSheet extends StatefulWidget {
  const SpeechToTextBottomSheet({
    super.key,
    required this.onVoiceSearch
  });

  final void Function(String value) onVoiceSearch;

  @override
  State<SpeechToTextBottomSheet> createState() => _SpeechToTextBottomSheetState();
}

class _SpeechToTextBottomSheetState extends State<SpeechToTextBottomSheet> {

  final speechToText = SpeechToText();
  bool isListening = false;
  bool isEmptySearch = false;
  String searchKeyword = '';

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.kBorderRadius),
            topRight: Radius.circular(Sizes.kBorderRadius)
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: ()=> Navigator.of(context).pop(),
                    icon:  Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(
              height: Sizes.kPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.kPadding),
              child: Text(
                isListening ? lang.spechToTextBotomShet_releaseBtn : lang.spechToTextBotomShet_holdBtn,
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              isEmptySearch ? lang.spechToTextBotomShet_noUnderstand : '',
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall!.copyWith(
                fontSize: 10
              ),
            ),
            const SizedBox(
              height: Sizes.kPadding * 2,
            ),
            AvatarGlow(
              animate: isListening,
              glowRadiusFactor: 0.4,
              glowColor: theme.colorScheme.primary,
              child: GestureDetector(
                onTapDown: (details) async{
        
                  if(!isListening){
        
                    final isAvailable = await speechToText.initialize();
                    if(isAvailable){
                      setState(() {
                        isListening = true;
                        isEmptySearch = false;
                        searchKeyword = '';
                      });
                      await speechToText.listen(
                        listenOptions: SpeechListenOptions(
                          partialResults: false,
                          listenMode: ListenMode.search
                        ),
                        localeId: 'es_MX',
                        onResult: (result){
                          if(result.finalResult && result.toFinal().recognizedWords.isNotEmpty){
                            searchKeyword = result.toFinal().recognizedWords;
                            widget.onVoiceSearch(result.toFinal().recognizedWords);
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    }
                  }
                },
                onTapUp: (details) async{
                  await speechToText.stop();
                  setState(() {
                    isListening = false;
                  });
                  await Future.delayed(const Duration(milliseconds: 500));
                  if(searchKeyword.isEmpty){
                    setState(() {
                      isEmptySearch = true;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: theme.colorScheme.primary,
                  child: Flash(
                    animate: isListening,
                    infinite: true,
                    child: Icon(
                      CupertinoIcons.mic,
                      size: 30,
                      color: isListening ? theme.colorScheme.error : null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: Sizes.kPadding * 4,
            ),
          ],
        ),
      ),
    );
  }
}