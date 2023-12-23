import 'package:flutter/material.dart';

import '/utils/utils.dart';


class CustomAppBar extends StatelessWidget{
  const CustomAppBar({
    super.key,
    required this.actions,
    required this.leading,
    required this.title
  });

  final Widget leading;
  final List<Widget> actions;
  final String title;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Sizes.kPadding * 0.5
          ),
          child: leading,
        ),
        const Spacer(),
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.titleSmall,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions,
          ),
        )
      ]
    );
  }

}