import 'package:flutter/material.dart';
import 'package:todo/components/my_isdone_button.dart';
import 'package:todo/components/my_text_field.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isDone = false;
  final TextEditingController editController = TextEditingController();

  void switchIsDone() {
    setState(() {
      isDone = !isDone;
    });
  }

  Text taskDoneOrNot() {
    return isDone
        ? Text(
            editController.text,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          )
        : Text(editController.text, style: null);
  }

  Text labelDoneOrNot() {
    return isDone ? const Text('is done') : const Text('is not done yet');
  }

  Icon iconDoneOrNot() {
    return isDone ? const Icon(Icons.check) : const Icon(Icons.remove_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title
              const Text(
                'Edit Todo',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              // textfield
              MyTextField(controller: editController),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyIsDoneButton(
                    onPressed: () {
                      switchIsDone();
                    },
                    icon: iconDoneOrNot(),
                    label: labelDoneOrNot(),
                  ),
                ],
              ),
              const SizedBox(height: 300.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.grey.shade800,
                    onPressed: () {
                      // bool delete = true;
                      // Navigator.pop(context, [delete]);
                    },
                    child: const Icon(Icons.delete),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context, [
                        taskDoneOrNot(),
                        iconDoneOrNot(),
                      ]);
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
