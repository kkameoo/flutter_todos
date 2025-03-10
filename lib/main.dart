import 'package:flutter/material.dart';
import 'package:flutter_todos/list.dart';
import 'package:flutter_todos/writeForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const Placeholder(),
      initialRoute: "/",
      routes: {
        "/": (context) => ListPage(),
        "/write": (content) => WriteForm(),
      },
    );
  }
}
