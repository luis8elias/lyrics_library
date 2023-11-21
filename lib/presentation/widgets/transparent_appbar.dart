import 'package:flutter/material.dart';


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
        SizedBox(
          width: 100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: leading,
          )
        ),
        Text(
          title,
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(
          width: 100,
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