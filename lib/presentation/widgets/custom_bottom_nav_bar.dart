import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/presentation.dart';
import '/utils/constants/sizes.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.body,
    this.appBar,
    this.buttonBottomRow,
    this.hideBottomNavBar = false
  });

  final int selectedIndex;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? buttonBottomRow;
  final bool hideBottomNavBar;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {


  static late List<BottomNavigationBarItem>items;
  @override
  void initState() {
    super.initState();
    final lang = Lang.current;
    items = [
      BottomNavigationBarItem(
        icon: CupertinoIcons.music_note,
        onPressed: (context) => {
          GoRouter.of(context).goNamed(
            SongsListScreen.routeName
          ),
        },
        label: lang.app_songs
      ),
      BottomNavigationBarItem(
        icon: CupertinoIcons.music_note_list,
        onPressed: (context) => {
          GoRouter.of(context).goNamed(
            SetlistsScreen.routeName
          ),
        },
        label: lang.app_setlists
      ),
      BottomNavigationBarItem(
        icon: CupertinoIcons.collections,
        onPressed: (context) => {
          GoRouter.of(context).goNamed(
           GenresListScreen.routeName
          )
        },
        label: lang.app_genres
      ),
      BottomNavigationBarItem(
        icon: CupertinoIcons.ellipsis_vertical,
        onPressed: (context){
          GoRouter.of(context).goNamed(
            MoreOptionsScreen.routeName
          );
        },
        label: lang.app_more
      )
    ];
  } 
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: widget.appBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.body,
          ),
          if(!widget.hideBottomNavBar && widget.buttonBottomRow == null)
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return  Visibility(
                  visible: !isKeyboardVisible,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: Sizes.kBottomNavHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: items.map((item) => IconBtn(
                            icon: item.icon,
                            selectedIndex: widget.selectedIndex,
                            index: items.indexOf(item),
                          )).toList()
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if(widget.buttonBottomRow != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return  Visibility(
                  visible: !isKeyboardVisible,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: Sizes.kBottomNavHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.inverseSurface.withOpacity(0.6),
                        ),
                        child: widget.buttonBottomRow
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class IconBtn extends StatelessWidget {
  const IconBtn({
    super.key,
    required this.icon,
    required this.index,
    required this.selectedIndex,
  });

  final IconData icon;
  final int selectedIndex;
  final int index;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      enableFeedback: false,
      onTap: (){
        if(selectedIndex != index){
          _CustomBottomNavBarState.items[index].onPressed(context);
        }
      },
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
              child: Icon(
                icon,
                color: selectedIndex ==  index ? theme.primaryColor : theme.colorScheme.onBackground, 
                size: 20,
              ),
            ),
            Text(
              _CustomBottomNavBarState.items[index].label,
              style: TextStyle(
                color: selectedIndex ==  index ? theme.primaryColor : theme.colorScheme.onBackground
              ),
            ),
          ],
        ),
      )
    );
  }
}

class BottomNavigationBarItem{

  final IconData icon;
  final void Function(BuildContext context) onPressed;
  final String label;

  const BottomNavigationBarItem({
    required this.icon, 
    required this.onPressed,
    required this.label
  });

}