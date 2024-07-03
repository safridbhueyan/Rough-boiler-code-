import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Tododatabase {
  List toDolist = [];

  // reference the box

  final _mybox = Hive.box('mybox');
  //run this method first time ever opening this app

  void createInitialData() {
    toDolist = [
      ["Task1", false],
      ["Exercise", false],
    ];
  }

  //load the data from the database
  void loadData() {
    toDolist = _mybox.get("TODOLIST");
  }

//update the database

  void updateDataBase() {
    _mybox.put("TODOLIST", toDolist);
  }
}
