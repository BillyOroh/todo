import 'package:flutter/material.dart';
import 'package:todo/components/my_isdone_button.dart';
import 'package:todo/components/my_text_field.dart';
import 'package:todo/components/my_float_button.dart';

import '../model/task.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController editController = TextEditingController();

  Task? task;

  @override
  void initState() {
    super.initState();
    task = widget.task;

    if (task != null) {
      editController.text = task!.todo;
    }
  }

  void switchIsDone() {
    setState(() {
      task!.isDone = !task!.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdding = task == null;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title
              Text(
                isAdding ? 'Add Todo' : 'Edit Todo',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              MyTextField(controller: editController),
              const SizedBox(height: 20.0),
              isAdding
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: MyIsDoneButton(
                          onPressed: () {
                            switchIsDone();
                          },
                          backgroundColor: task?.isDone ?? false
                              ? Colors.grey
                              : Colors.white),
                    ),
              const SizedBox(height: 300.0),
              // buttons
              isAdding
                  ? Center(child: addButton(isAdding, context))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyFloatButton(
                          heroTag: 'delete',
                          backgroundColor: Colors.red,
                          onPressed: () {
                            if (task != null) {
                              task!.todo = "delete";
                            }
                            Navigator.pop(context, task);
                          },
                          child: const Icon(Icons.delete),
                        ),
                        addButton(isAdding, context),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  MyFloatButton addButton(bool isAdding, BuildContext context) {
    return MyFloatButton(
      heroTag: 'add',
      backgroundColor: Colors.black,
      onPressed: () {
        if (isAdding == true) {
          task = Task(todo: editController.text, isDone: false);
        } else {
          task = Task(todo: editController.text, isDone: task!.isDone);
        }
        if (editController.text.isNotEmpty) {
          Navigator.pop(context, task);
        }
      },
      child: Icon(isAdding ? Icons.add_circle : Icons.check),
    );
  }
}
