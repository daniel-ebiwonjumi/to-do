import 'package:flutter/material.dart';
import 'package:to_do_app_practice/home.dart';

void main() {
  runApp(const MyToDoApp());
}

class MyToDoApp extends StatelessWidget {
  const MyToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
