import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '/presentation/widgets/transparent_appbar.dart';
import '/presentation/presentation.dart';
import '/utils/constants/sizes.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.body,
    required this.scaffoldKey,
    this.appBar,
    this.buttonBottomRow
  });

  final int selectedIndex;
  final Widget body;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final CustomAppBar? appBar;
  final Widget? buttonBottomRow;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {


  static late List<BottomNavigationBarItem>items;
  @override
  void initState() {
    super.initState();
    items = [
      BottomNavigationBarItem(
        icon: CupertinoIcons.home,
        onPressed: (context) => {
          GoRouter.of(context).goNamed(
            HomeScreen.routeName
          ),
        },
        label: 'Home'
      ),
      BottomNavigationBarItem(
        icon: CupertinoIcons.music_note,
        onPressed: (context) => {
          GoRouter.of(context).goNamed(
            SongsListScreen.routeName
          ),
        },
        label: 'Songs'
      ),
      BottomNavigationBarItem(
        icon: CupertinoIcons.list_bullet,
        onPressed: (context) => {
          GoRouter.of(context).goNamed(
           GenresListScreen.routeName
          )
        },
        label: 'Genres'
      ),
      BottomNavigationBarItem(
        icon: CupertinoIcons.ellipsis_vertical,
        onPressed: (context){
          widget.scaffoldKey.currentState?.openDrawer();
        },
        label: 'More'
      )
    ];
  } 
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.body,
          ),
          if(widget.buttonBottomRow == null)
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
                          color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                        ),
                        child: widget.buttonBottomRow
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if(widget.appBar != null)
          Align(
            alignment: Alignment.topCenter,
            child: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return  Visibility(
                  visible: !isKeyboardVisible,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: Sizes.kAppBarSize,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: widget.appBar,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
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
            Icon(
              icon,
              color: selectedIndex ==  index ? theme.primaryColor : theme.colorScheme.onBackground, 
              size: 20,
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