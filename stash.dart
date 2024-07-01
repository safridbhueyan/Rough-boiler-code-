import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          // ignore: prefer_const_constructors
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orangeAccent,
          )),
      home: const Homepage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:to_do_app/pages/util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 214, 151),
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          TodoTile(
            taskName: "tutorial",
            taskCompleted: true,
            onChanged: (p0) {},
          ),
          TodoTile(
            taskName: "new first app",
            taskCompleted: true,
            onChanged: (p0) {},
          ),
          TodoTile(
            taskName: "youll be proo",
            taskCompleted: true,
            onChanged: (p0) {},
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: EdgeInsets.all(24),
        // ignore: sort_child_properties_last
        child: Row(
          children: [
            //checkbox
            Checkbox(value: taskCompleted, onChanged: onChanged),
            //task name
            Text(taskName),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
