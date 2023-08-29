import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';
import 'package:todo/scaffolds/add_screen.dart';
import 'package:todo/scaffolds/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = List.empty(growable: true);
  int selectedIndex = -1;
  bool isLineThrough = false;

  _navigateToAddScreen(BuildContext context) async {
    final List results = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddScreen()),
    );
    setState(() {
      tasks.add(Task(
          title: results[0],
          icon: results[1],
          titleText: results[2],
          doneOrNot: results[3]));
      if (results[3] == true) {
        isLineThrough = true;
      }
    });
  }

  _navigateToEditScreen(BuildContext context) async {
    final List results = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditScreen(
                titleOnly: tasks[selectedIndex].titleText,
                check: tasks[selectedIndex].doneOrNot,
              )),
    );
    if (results[0] == true) {
      setState(() {
        tasks.removeAt(selectedIndex);
      });
    } else {
      setState(() {
        tasks[selectedIndex].title = results[0];
        tasks[selectedIndex].icon = results[1];
        tasks[selectedIndex].titleText = results[2];
        tasks[selectedIndex].doneOrNot = results[3];
        if (results[3] == true) {
          isLineThrough = true;
        }
      });
    }
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
                  _navigateToAddScreen(context);
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
                    return Card(
                      child: ListTile(
                        leading: tasks[index].icon,
                        title: isLineThrough
                            ? tasks[index].title
                            : Text(tasks[index].titleText),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                              _navigateToEditScreen(context);
                            });
                          },
                        ),
                      ),
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
// isDone
//         ? Text(
//             editController.text,
//             style: const TextStyle(decoration: TextDecoration.lineThrough),
//           )
//         : Text(editController.text, style: null);

// tasks[index].title,