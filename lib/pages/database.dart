import 'package:hive/hive.dart';

class ToDoDatabase {
  List todolist = [];
  final mybox = Hive.box("mybox");
  void createInitialData() {
    todolist = [
      ["Make some noise", false],
      ["Try Something New", false]
    ];
  }

  void loadData() {
    todolist = mybox.get("TODOLIST");
  }

  void updateData() {
    mybox.put("TODOLIST", todolist);
  }
}
