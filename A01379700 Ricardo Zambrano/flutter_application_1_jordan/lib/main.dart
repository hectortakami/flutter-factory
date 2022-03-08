import 'package:flutter/material.dart';
import 'package:flutter_application_1_copia/screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Try changing the color
      ),
      home: const Home(),
    );
  }
}
