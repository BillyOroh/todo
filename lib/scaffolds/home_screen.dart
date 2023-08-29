import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';
import 'package:todo/scaffolds/edit_screen.dart';

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

  // _navigateToAddScreen(BuildContext context) async {
  //   final List? results = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const AddScreen()),
  //   );
  //   if (results != null) {
  //     setState(() {
  //       tasks.add(Task(
  //           title: results[0],
  //           icon: results[1],
  //           titleText: results[2],
  //           doneOrNot: results[3]));
  //       if (results[3] == true) {
  //         isLineThrough = true;
  //       }
  //     });
  //   }
  // }

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
    if (result.isDone == false && result.todo.isNotEmpty) {
      setState(() {
        tasks.add(result);
      });
      print("add_operation ${result.todo}");
      return;

    }

    //edit
    setState(() {
      tasks.insert(selectedIndex, result);
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
              // title
              const Text(
                'Add App',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
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
                  padding: EdgeInsets.all(20.0),
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
    return Card(
      child: ListTile(
        leading: Icon(task.isDone ? Icons.check : Icons.remove),
        title: Text(
          task.todo,
          style: TextStyle(
            decoration:
                task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onTap,
        ),
      ),
    );
  }
}
