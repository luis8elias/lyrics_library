import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/config/lang/generated/l10n.dart';
import '/utils/constants/sizes.dart';

class ChangeReadSongFontSizeBottomSheet extends StatefulWidget {
  const ChangeReadSongFontSizeBottomSheet({
    super.key,
    required this.defaultFontSize,
    required  this.onFontSizeChanged
  });

  final double defaultFontSize;
  final void Function(double newFontSize) onFontSizeChanged;


  @override
  State<ChangeReadSongFontSizeBottomSheet> createState() => _ChangeReadSongFontSizeBottomSheetState();
}

class _ChangeReadSongFontSizeBottomSheetState extends State<ChangeReadSongFontSizeBottomSheet> {

  late double fontSize;

  @override
  void initState() {
    fontSize = widget.defaultFontSize;
    super.initState();
  }


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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon:  Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              )
            ),

            Text(
              lang.changefontSizeScreen_title,
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: Sizes.kPadding * 2,
            ),
            Slider(
              min: 15,
              max: 30,
              divisions: 15,
              value: fontSize,
              onChanged: (newFontSize){
                setState(() {
                  fontSize = newFontSize;
                });
                widget.onFontSizeChanged(newFontSize);
              }
            ),
            const SizedBox(
              height: Sizes.kPadding * 3,
            ),
          ],
        ),
      ),
    );
  }
}