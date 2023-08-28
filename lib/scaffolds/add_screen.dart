import 'package:flutter/material.dart';
import 'package:todo/components/my_isdone_button.dart';
import 'package:todo/components/my_text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController addController = TextEditingController();
  bool isDone = false;

  void switchIsDone() {
    setState(() {
      isDone = !isDone;
    });
  }

  Text taskDoneOrNot() {
    return isDone
        ? Text(
            addController.text,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          )
        : Text(addController.text, style: null);
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
                'Add Todo',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              // textfield
              MyTextField(controller: addController),
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
              FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: () {
                  Navigator.pop(context, [
                    taskDoneOrNot(),
                    iconDoneOrNot(),
                  ]);
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
