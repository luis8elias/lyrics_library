import 'package:flutter/material.dart';

import '/presentation/features/songs/shared/model/song_model.dart';
import '/utils/constants/sizes.dart';

class SongForm extends StatefulWidget {
  const SongForm({
    super.key,
    this.songModel,
    required this.titleInputLabel,
    required this.onTitleChanged,
    required this.onLyricChanged,
  });

  final SongModel? songModel;
  final String titleInputLabel;
  final void Function(String name) onTitleChanged;
  final void Function(String name) onLyricChanged;

  @override
  State<SongForm> createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {

  final titleNode = FocusNode();
  final lyricNode = FocusNode();

  @override
  void initState() {
    titleNode.requestFocus();
    super.initState();
  }
  


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kPadding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Sizes.kAppBarSize + 5,
            ),
            TextFormField(
              initialValue: widget.songModel?.title,
              focusNode: titleNode,
              onFieldSubmitted: (String value){
                lyricNode.requestFocus();
              },
              style: theme.textTheme.displayMedium?.copyWith(
                color: theme.colorScheme.onSurface
              ),
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) => widget.onTitleChanged(value),
              decoration: InputDecoration(
                hintText: widget.titleInputLabel,
                fillColor: theme.colorScheme.background,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle:  theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.outline
                ),
              ),
            ),
            TextFormField(
              initialValue: widget.songModel?.lyric,
              focusNode: lyricNode,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface
              ),
              onChanged: (value) => widget.onLyricChanged(value),
              maxLines: null,
              decoration: InputDecoration(
                hintText: '',
                fillColor: theme.colorScheme.background,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle:  theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.outline
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}