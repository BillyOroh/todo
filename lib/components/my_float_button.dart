import 'package:flutter/material.dart';

class MyFloatButton extends StatelessWidget {
  final Object heroTag;
  final Color backgroundColor;
  final void Function() onPressed;
  final Widget child;
  const MyFloatButton({
    super.key,
    required this.heroTag,
    required this.backgroundColor,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: child,
    );
  }
}
