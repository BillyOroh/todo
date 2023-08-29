import 'package:flutter/material.dart';

class Task {
  Widget title;
  Widget icon;
  String titleText;
  bool doneOrNot;

  Task({
    required this.title,
    required this.icon,
    required this.titleText,
    required this.doneOrNot,
  });
}
