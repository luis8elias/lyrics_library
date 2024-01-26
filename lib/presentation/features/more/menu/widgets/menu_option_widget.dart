import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';

enum MenuRoundedOption{
  top,
  bottom,
  none,
  all
}

class MenuOptionWidget extends StatelessWidget {
  const MenuOptionWidget({
    super.key,
    required this.icon,
    required this.menuRoundedOption,
    required this.title,
    required this.onPressed,
    this.color 
  });

  final MenuRoundedOption menuRoundedOption;
  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.only(
        topLeft: menuRoundedOption == MenuRoundedOption.top  || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
        topRight: menuRoundedOption == MenuRoundedOption.top || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
        bottomLeft: menuRoundedOption == MenuRoundedOption.bottom || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
        bottomRight: menuRoundedOption == MenuRoundedOption.bottom || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
      ),
      color: theme.colorScheme.inverseSurface.withOpacity(0.5),
      child: ListTile(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: menuRoundedOption == MenuRoundedOption.top || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
            topRight: menuRoundedOption == MenuRoundedOption.top || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
            bottomLeft: menuRoundedOption == MenuRoundedOption.bottom || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
            bottomRight: menuRoundedOption == MenuRoundedOption.bottom || menuRoundedOption == MenuRoundedOption.all ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
          ),
        ),
        minLeadingWidth: 25,
        onTap: onPressed,
        trailing: Icon(
          icon,
          color: color ?? theme.colorScheme.onBackground,
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: color ?? theme.colorScheme.onBackground,
          ),
        )
      ),
    );
  }
}


class MenuOptionDivider extends StatelessWidget {
  const MenuOptionDivider({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      height: 0.5,
      color : theme.colorScheme.outline
    );
  }
}