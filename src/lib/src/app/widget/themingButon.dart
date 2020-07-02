import 'package:flutter/material.dart';

import '../../../main.dart';

/// Others
import '../../others/images.dart';

class ThemingButon extends StatefulWidget {
  ThemingButon({
    Key key,
  }) : super(key: key);

  @override
  _ThemingButonState createState() => _ThemingButonState();
}

class _ThemingButonState extends State<ThemingButon> {
  final Duration duration = const Duration(milliseconds: 500);
  bool _isDarkModeOn;

  bool isAnimationCompleted = true;

  final UniqueKey key1 = UniqueKey();
  final UniqueKey key2 = UniqueKey();

  @override
  void initState() {
    _isDarkModeOn = themeStore.darkMode;
    super.initState();
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () async {
        if (isAnimationCompleted == true) {
          if (mounted) {
            setState(() {
              _isDarkModeOn = !_isDarkModeOn;
            });
          }

          await Future.delayed(duration, () {
            themeStore.change(!themeStore.darkMode);
          });
        }
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: duration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            animation.addListener(() {
              if (animation.status == AnimationStatus.reverse) {
                isAnimationCompleted = false;
              } else if (animation.status == AnimationStatus.forward) {
                isAnimationCompleted = false;
              } else if (animation.status == AnimationStatus.dismissed) {
                isAnimationCompleted = false;
              } else if (animation.status == AnimationStatus.completed) {
                isAnimationCompleted = true;
              }
            });

            final Animation<Offset> inAnimation = Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(animation);

            final Animation<Offset> outAnimation = Tween<Offset>(
              begin: Offset(-1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(animation);

            if (child.key == ValueKey(key1)) {
              return ClipRect(
                child: SlideTransition(
                  position: inAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      child,
                    ],
                  ),
                ),
              );
            } else {
              return ClipRect(
                child: SlideTransition(
                  position: outAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      child,
                    ],
                  ),
                ),
              );
            }
          },
          child: _isDarkModeOn == true
              ? Image.asset(
                  Images.sun,
                  key: ValueKey(key1),
                  width: 48.0,
                )
              : Image.asset(
                  Images.moon,
                  key: ValueKey(key2),
                  width: 48.0,
                ),
        ),
      ),
    );
  }
}
