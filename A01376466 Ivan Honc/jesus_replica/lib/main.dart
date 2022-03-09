import 'package:flutter/material.dart';

import 'package:jesus_replica/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola mundo',
        theme: ThemeData.light(),
        home: HomeScreen());
  }
}
