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
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, size: 24),
            onPressed: () => _buildBottomSheet(context),
          ),
        ],
        title: const Text('Counter App'),
        elevation: 0,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  void _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Divider(
                color: Colors.transparent,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: ListTile(
                  title: Text(
                      "This app was built following Fernando Herrera's Flutter playlist."),
                  onTap: () => {},
                ),
              ),
              ListTile(
                title: Text(''),
              ),
              Divider(
                color: Colors.transparent,
              )
            ],
          );
        });
  }
}
