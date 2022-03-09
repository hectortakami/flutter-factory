import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  //variable, propiedad
  int counter = 10;

  @override
  Widget build(BuildContext context) {
    const fontSize30 = TextStyle(fontSize: 30);

    return Scaffold(
        //Button Section
        appBar: AppBar(
          title: const Text('CounterScreen'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/Ticket.jpg')),
              const Text(
                'Numero de tabs',
                style: fontSize30,
              ),
              Text(
                '$counter',
                style: fontSize30,
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code),
          onPressed: () {
            counter++;
            setState(() {});
          },
        ));
  }
}
