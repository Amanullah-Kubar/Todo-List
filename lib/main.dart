import 'package:demo/SplashScreen.dart';
import 'package:demo/ToDoApp.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => SplashScreen(),
        "/Todoapp" : (context) => Todoapp(),
      },
    );
  }
}