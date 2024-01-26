import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/app/providers/providers.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/features/more/menu/widgets/menu_option_widget.dart';
import '/presentation/widgets/widgets.dart';
import '/utils/constants/sizes.dart';
import 'widgets/profile_menu_tile.dart';

class MoreOptionsScreen extends ConsumerWidget {
  const MoreOptionsScreen({super.key});

  static const String routeName = '/more';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final sessionProv = ref.watch(sessionProvider);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                  height: Sizes.kPadding
                ),
                const ProfileMenuTile(),
                const SizedBox(
                  height: Sizes.kPadding,
                ),
                
                MenuOptionWidget(
                  onPressed: (){},
                  title: lang.moreOptionsScreen_groups,
                  icon: CupertinoIcons.person_3_fill,
                  menuRoundedOption: MenuRoundedOption.top,
                ),
                const MenuOptionDivider(),
                MenuOptionWidget(
                  onPressed: (){},
                  title: lang.moreOptionsScreen_metrics,
                  icon: CupertinoIcons.chart_bar_square,
                  menuRoundedOption: MenuRoundedOption.none,
                ),
                const MenuOptionDivider(),
                MenuOptionWidget(
                  onPressed: (){},
                  title: lang.moreOptionsScreen_scanLyrics,
                  icon: CupertinoIcons.qrcode,
                  menuRoundedOption: MenuRoundedOption.bottom,
                ),
                const SizedBox(
                  height: Sizes.kPadding,
                ),
                MenuOptionWidget(
                  onPressed: (){},
                  title: lang.moreOptionsScreen_fontSize,
                  icon: CupertinoIcons.textformat_size,
                  menuRoundedOption: MenuRoundedOption.top,
                ),
                const MenuOptionDivider(),
                MenuOptionWidget(
                  onPressed: (){},
                  title: lang.moreOptionsScreen_lang,
                  icon: Icons.language_outlined,
                  menuRoundedOption: MenuRoundedOption.bottom,
                ),
                const SizedBox(
                  height: Sizes.kPadding ,
                ),
                // MenuOptionWidget(
                //   onPressed: ()=> sessionProv.logoutUser(),
                //   title: 'Logout',
                //   icon: Icons.logout_outlined,
                //   menuRoundedOption: MenuRoundedOption.all,
                //   color: theme.colorScheme.error,
                // ),
                Material(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Sizes.kBorderRadius),
                    topRight: Radius.circular(Sizes.kBorderRadius),
                    bottomLeft: Radius.circular(Sizes.kBorderRadius),
                    bottomRight: Radius.circular(Sizes.kBorderRadius),
                  ),
                  color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Sizes.kBorderRadius),
                        topRight: Radius.circular(Sizes.kBorderRadius),
                        bottomLeft: Radius.circular(Sizes.kBorderRadius),
                        bottomRight: Radius.circular(Sizes.kBorderRadius),
                      ),
                    ),
                    minLeadingWidth: 25,
                    onTap: sessionProv.isLoadingLogout 
                    ? null 
                    : ()=> sessionProv.logoutUser(),
                    trailing: sessionProv.isLoadingLogout 
                    ? const SizedBox(
                      width: 20,
                      child: CleanLoaderWidget(
                        iosSize: 10,
                        androidSize: 20,
                      ),
                    )
                    : Icon(
                      Icons.logout_outlined,
                      color: theme.colorScheme.error,
                    ),
                    title: Text(
                      'Logout',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}