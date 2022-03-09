import 'package:flutter/material.dart';
import 'package:counter_app_replica/screens/counter_screen.dart';
import 'package:counter_app_replica/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        //home: HomeScreen()
        home: const CounterScreen());
  }
}
