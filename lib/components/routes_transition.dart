import 'package:flutter/material.dart';

Route slideRoute({required Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, a, sA, c) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: curve));
      return SlideTransition(
        position: a.drive(tween),
        child: c,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

Route fadeRoute({
  required Widget page,
  double duration = 900,
  }) {
  return PageRouteBuilder(
    transitionsBuilder: (_, __, ___, c) {
      return FadeTransition(
        opacity: __,
        child: c,
      );
    },
    transitionDuration: Duration(milliseconds: duration.toInt()),
    pageBuilder: (_, __, ___) => page,
  );
}