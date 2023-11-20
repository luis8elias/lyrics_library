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
        leading,
        Text(
          title,
          style: theme.textTheme.titleSmall,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        )
      ]
    );
  }

}