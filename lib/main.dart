import 'package:flutter/material.dart';
import 'package:calculator/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        accentColor: Colors.white70,
        primaryColor: Colors.black,

      ),
      home: MyHomeScreen(),
    );
  }
}