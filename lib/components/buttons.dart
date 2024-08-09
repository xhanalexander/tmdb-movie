import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final Color? backgroundColors;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? marginSize;
  final VoidCallback onPressed;
  final Gradient grads;
  final Widget childs;
  
  const FormButton({
    super.key,
    required this.childs,
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.grads = const LinearGradient(
      colors: [Colors.purpleAccent, Colors.purple],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    this.marginSize = const EdgeInsets.all(0),
    this.backgroundColors = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: marginSize,
      decoration: BoxDecoration(
        gradient: grads,
        borderRadius: borderRadius,
        border: Border.all(
          color: Colors.purple,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColors,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius!,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onPressed,
        child: childs,
      ),
    );

  }
}