import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;

  void restartCounter() => setState(() => {counter = 0});
  void addToCounter(int number) => setState(() => {counter += number});

  @override
  Widget build(BuildContext context) {
    const fontSize24 = TextStyle(fontSize: 24);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        elevation: 0, // Removing shadow in the AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current counter:',
              style: fontSize24,
            ),
            Text(
              '$counter',
              style: fontSize24,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Adding a location to our buttons.
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => addToCounter(-1),
              child: Icon(Icons.exposure_minus_1),
            ),
            FloatingActionButton(
              onPressed: restartCounter,
              child: Icon(Icons.restart_alt),
            ),
            FloatingActionButton(
              onPressed: () => addToCounter(1),
              child: Icon(Icons.plus_one),
            )
          ],
        ),
      ),
    );
  }
}
