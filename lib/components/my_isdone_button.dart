import 'package:flutter/material.dart';

class MyIsDoneButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;

  const MyIsDoneButton(
      {super.key, required this.onPressed, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        color: Colors.black,
        Icons.check,
      ),
      label: const Text(style: TextStyle(color: Colors.black), "done"),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
