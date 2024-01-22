import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_library/config/lang/generated/l10n.dart';
import 'package:lyrics_library/presentation/features/more/menu/widgets/menu_option_widget.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';

import '/presentation/widgets/widgets.dart';
import 'widgets/profile_menu_tile.dart';

class MenuOptionsScreen extends StatelessWidget {
  const MenuOptionsScreen({super.key});

  static const String routeName = '/more';

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.moreOptionsScreen_title,
          style: theme.textTheme.titleSmall,
        ),
      ),
      body:  CustomBottomNavBar(
        selectedIndex: 3,
        body: SingleChildScrollView(
          child : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kPadding
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: Sizes.kPadding * 2,
                ),
                const ProfileMenuTile(),
                const SizedBox(
                  height: Sizes.kPadding * 2,
                ),
                const MenuOptionWidget(
                  title: 'Setlist',
                  icon: CupertinoIcons.music_note_list,
                  menuRoundedOption: MenuRoundedOption.top,
                ),
                const MenuOptionDivider(),
                const MenuOptionWidget(
                  title: 'Groups',
                  icon: CupertinoIcons.person_3_fill,
                  menuRoundedOption: MenuRoundedOption.none,
                ),
                const MenuOptionDivider(),
                const MenuOptionWidget(
                  title: 'Font size',
                  icon: CupertinoIcons.textformat_size,
                  menuRoundedOption: MenuRoundedOption.none,
                ),
                const MenuOptionDivider(),
                MenuOptionWidget(
                  title: 'Logout',
                  icon: Icons.logout_outlined,
                  menuRoundedOption: MenuRoundedOption.bottom,
                  color: theme.colorScheme.error,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}