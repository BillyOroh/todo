import 'package:flutter/material.dart';

class MyIsDoneButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final Widget label;

  const MyIsDoneButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
      ),
    );
  }
}
