import 'package:flutter/material.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';

enum MenuRoundedOption{
  top,
  bottom,
  none
}

class MenuOptionWidget extends StatelessWidget {
  const MenuOptionWidget({
    super.key,
    required this.icon,
    required this.menuRoundedOption,
    required this.title,
    this.color 
  });

  final MenuRoundedOption menuRoundedOption;
  final String title;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.only(
        topLeft: menuRoundedOption == MenuRoundedOption.top ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
        topRight: menuRoundedOption == MenuRoundedOption.top ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
        bottomLeft: menuRoundedOption == MenuRoundedOption.bottom ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
        bottomRight: menuRoundedOption == MenuRoundedOption.bottom ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
      ),
      color: theme.colorScheme.inverseSurface.withOpacity(0.5),
      child: ListTile(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: menuRoundedOption == MenuRoundedOption.top ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
            topRight: menuRoundedOption == MenuRoundedOption.top ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
            bottomLeft: menuRoundedOption == MenuRoundedOption.bottom ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
            bottomRight: menuRoundedOption == MenuRoundedOption.bottom ? const Radius.circular(Sizes.kBorderRadius) : const Radius.circular(0),
          ),
        ),
        minLeadingWidth: 25,
        onTap: (){},
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