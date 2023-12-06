import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/pages/database.dart';
import 'package:hive/hive.dart';

import 'dialog_box.dart';
import 'todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box("mybox");
  final controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void compY(bool? value, index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateData();
  }

  void saveTask() {
    setState(() {
      db.todolist.add([controller.text, false]);
      controller.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void deleteTask(index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateData();
  }

  void createNew() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: saveTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateData();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: false,
      drawer: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Drawer(
          child: Column(
            children: [
              DrawerHeader(child: Icon(Icons.handyman_sharp, size: 80)),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  hoverColor: Colors.purpleAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.settings_applications_sharp),
                  title: Text("Settings"),
                  hoverColor: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: db.todolist.length,
          itemBuilder: (context, index) {
            return TodoTile(
              task: db.todolist[index][0],
              user: db.todolist[index][1],
              onChanged: (value) => {
                compY(value, index),
              },
              delTask: (context) => deleteTask(index),
            );
          }),
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent[50],
        title: const Center(child: Text("TODO")),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {
          _key.currentState!.openDrawer();
        },),
        actions: [IconButton(onPressed: () {
          SystemNavigator.pop();
        }, icon: const Icon(Icons.logout))],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: createNew,
        child: const Icon(Icons.add),
      ),
    );
  }
}
