import 'package:flutter/material.dart';

AppBar customAppBar(
  BuildContext context, 
  String title, 
  {List<Widget> childs = const []}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.transparent],
          begin: Alignment(0, -2),
          end: Alignment.bottomCenter,
        ),
      ),
    ),
    actions: [
      ...childs,
    ],
  );
}