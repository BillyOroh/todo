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

  _navigateToAddScreen(BuildContext context) async {
    final List results = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddScreen()),
    );
    setState(() {
      tasks.add(Task(title: results[0], icon: results[1]));

      // if (results[2] == true) {
      //   check = TextStyle(decoration: TextDecoration.lineThrough);
      // }
    });
  }

  _navigateToEditScreen(BuildContext context) async {
    final List results = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditScreen()),
    );
    setState(() {
      tasks[selectedIndex].title = results[0];
      tasks[selectedIndex].icon = results[1];
    });
  }

  // _navigateToDelete(BuildContext context) async {
  //   final List results = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const EditScreen()),
  //   );
  //   if (results[0] == true) {
  //     setState(() {
  //       tasks.removeAt(selectedIndex);
  //     });
  //   }
  // }

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
                //color: Colors.grey,
                height: 200,
                width: 400,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: tasks[index].icon,
                        title: tasks[index].title,
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
