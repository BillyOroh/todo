import 'package:flutter/material.dart';
import '../model/task.dart';

class TodoItemCard extends StatelessWidget {
  const TodoItemCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  final Task task;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          leading: Icon(
            task.isDone ? Icons.check : Icons.remove,
            color: Colors.black,
          ),
          title: Text(
            task.todo,
            style: TextStyle(
              fontSize: 17.0,
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
