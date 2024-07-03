import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/pages/home_page.dart';

Future<void> main() async {
  //initializing hive

  await Hive.initFlutter();

  // Open a box
  await Hive.openBox('mybox');

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
