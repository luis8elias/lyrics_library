import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/widgets/speech_to_text_bottom_sheet.dart';
import '/utils/utils.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    super.key,
    required this.onChangeSearch,
    this.autoFocus = true
  });

  final void Function(String query) onChangeSearch;
  final bool autoFocus;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode  = FocusNode();
    controller = TextEditingController();
    if(widget.autoFocus){
      focusNode.requestFocus();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);

    return FadeIn(
      child: SizedBox(
        height: 40,
        child: TextFormField(
          focusNode: focusNode,
          onChanged: (value) => Debouncer.run(() {
            widget.onChangeSearch(value);
          }),
          controller: controller,
          cursorColor: theme.colorScheme.secondary,
          style: TextStyle(
            color: theme.colorScheme.onSurface
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              visualDensity: VisualDensity.standard,
              iconSize: 20,
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory
              ),
              onPressed: (){ 
                focusNode.unfocus();
                showModalBottomSheet(
                  enableDrag: false,
                  elevation: 0.0,
                  barrierColor: Colors.transparent,
                  context: context, 
                  builder: (context) => SpeechToTextBottomSheet(
                    onVoiceSearch: (value) {
                      controller.text = value;
                      widget.onChangeSearch(value);
                    },
                  )
                );
               },
              icon: Icon(
                CupertinoIcons.mic,
                color: theme.colorScheme.onBackground,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 15,
            ),
            hintText: lang.actions_search,
            hintStyle: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.outline,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
              borderSide: BorderSide(color:  theme.colorScheme.outline ),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}