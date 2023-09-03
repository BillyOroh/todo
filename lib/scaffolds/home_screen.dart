import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';
import 'package:todo/scaffolds/edit_screen.dart';
import 'package:todo/components/my_todoitem_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  int selectedIndex = 0;
  bool isAdding = true;

  void _navigateToEditScreen(BuildContext context, Task? task) async {
    final Task? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(task: task),
      ),
    );

    if (result == null) {
      return;
    }

    print("$selectedIndex ${result.todo} ${result.isDone}");

    //delete
    if (result.todo == "delete") {
      // tasks.indexWhere((e)=>e.id=="2") -1 01234;
      setState(() {
        tasks.removeAt(selectedIndex);
      });
      print("delete_operation delete ${result.todo}");
      return;
    }

    // add
    if (isAdding == true) {
      setState(() {
        tasks.add(result);
      });
      print("add_operation ${result.todo}");
      return;
    }

    //edit
    setState(() {
      tasks.add(result);
      tasks.removeAt(selectedIndex);
      print("edit_operation ${result.todo} $selectedIndex");
    });
    return;
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
              const SizedBox(height: 30.0),
              // title
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Todo App',
                  style: TextStyle(
                    fontSize: 25.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAdding = true;
                  });
                  _navigateToEditScreen(context, null);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Todo',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(),
                      Icon(Icons.add_circle_rounded),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              SizedBox(
                height: 300,
                width: 400,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final Task task = tasks[index];
                    return TodoItemCard(
                      task: task,
                      onTap: () {
                        setState(() {
                          isAdding = false;
                        });
                        selectedIndex = index;
                        _navigateToEditScreen(context, tasks[selectedIndex]);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
