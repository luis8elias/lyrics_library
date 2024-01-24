import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/utils/utils.dart';

class SearchSongInput extends StatefulWidget {
  const SearchSongInput({
    super.key,
    required this.onChangeSearch
  });

  final void Function(String query) onChangeSearch;

  @override
  State<SearchSongInput> createState() => _SearchSongInputState();
}

class _SearchSongInputState extends State<SearchSongInput> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return FadeIn(
      child: SizedBox(
        height: 40,
        child: TextFormField(
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
                if(controller.text.isNotEmpty){
                  controller.clear();
                  widget.onChangeSearch('');
                }
              },
              icon: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: theme.colorScheme.onBackground,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 15,
            ),
            hintText: 'Buscar',
            //suffixIcon: widget.suffixIcon,
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