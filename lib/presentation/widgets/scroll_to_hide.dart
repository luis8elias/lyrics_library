import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';

class ScrollToHide extends StatefulWidget {
  const ScrollToHide({
    super.key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 300)
  });

  final Widget child;
  final ScrollController scrollController;
  final Duration duration;

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {

  bool showBottomBar = true;
  bool isScrollingDown = false;

  void addScrollListener(){

    widget.scrollController.addListener(() {

      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {
            showBottomBar = false;
          });
        }
      }
      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {
            showBottomBar = true;
          });
        }
      }
    });
  }

  

  @override
  void initState() {
    widget.scrollController.addListener(()=> addScrollListener());
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener((){});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: showBottomBar ? Sizes.kBottomNavHeight : 0,
      child: Wrap(children: [widget.child],),
    );
  }
}