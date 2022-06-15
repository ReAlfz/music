import 'package:flutter/cupertino.dart';

class SlideUpTransition extends PageRouteBuilder {
  final Widget page;
  SlideUpTransition({required this.page}) : super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      },

      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),

      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}
class FadeTransitioned extends PageRouteBuilder {
  final Widget page;
  FadeTransitioned({required this.page}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return page;
    },

    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 400),

    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return Align(
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

class InstantTransitioned extends PageRouteBuilder {
  final Widget page;
  InstantTransitioned({required this.page}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return page;
    },

    transitionDuration: const Duration(seconds: 0),
    reverseTransitionDuration: const Duration(seconds: 0),
  );
}