import 'package:flutter/material.dart';
import 'package:animated_counter/animated_counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with TickerProviderStateMixin {
  int counter = 0;
  late CreatureCounter cre;

  @override
  void initState() {
    cre = CreatureCounter(
        vsync: this,
        initialCounter: counter,
        initialColors: [Colors.red, Colors.green, Colors.blue]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Counter App'),
            elevation: 0,
            leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            actions: [
              IconButton(
                  icon: const Icon(Icons.notifications), onPressed: () {})
            ],
            bottom: const TabBar(indicatorWeight: 4, isScrollable: true, tabs: [
              Tab(
                icon: Icon(Icons.ads_click),
                text: "Counter",
              ),
              Tab(
                icon: Icon(Icons.history),
                text: "Saved Items",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: "Settings",
              )
            ])),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Clicks Counter', style: TextStyle(fontSize: 30)),
                Text('$counter',
                    style: counter < 0
                        ? const TextStyle(fontSize: 30, color: Colors.red)
                        : const TextStyle(fontSize: 30, color: Colors.blue)),
                SizedBox(
                    height: 450, child: Stack(children: [cre.build(context)])),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                counter--;
                counter >= 0 ? cre.decrementCounter() : null;
                setState(() {});
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                counter++;
                counter > 0 ? cre.incrementCounter() : null;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
