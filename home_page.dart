import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialogueBox.dart';
import 'package:to_do_app/util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Tododatabase db = Tododatabase();
  late Box _mybox;
  //text controller
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _mybox = await Hive.openBox('mybox');

    //if this first time opening a data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    }
    // there are already existed data
    else {
      db.loadData();
    }
    setState(() {});
  }
//checkbox was tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });

    db.updateDataBase();
  }

  void saveNewtask() {
    setState(() {
      db.toDolist.add([_controller.text, false]);
      _controller.clear();
    });

    //to go back
    Navigator.of(context).pop();

    db.updateDataBase();
  }

  //for creating new task
  void craeteNewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewtask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

// Delete Task
  void deletetask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 214, 151),
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: craeteNewtask,
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDolist[index][0],
            taskCompleted: db.toDolist[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deletetask(index),
          );
        },
      ),
    );
  }
}
