import 'package:design_proposal/modules/events/widgets/assistant_tile.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:flutter/material.dart';

class SingleEvent extends StatefulWidget {
  const SingleEvent({Key? key}) : super(key: key);

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              )),
        ],
        title: Text('AWS Serverless',
            style: TextStyle(color: Colors.black, fontFamily: 'ProductSans')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => QrScanner()))
        },
        child: Icon(Icons.qr_code),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 16)),
          AssistantTile(name: 'Iván Honc'),
          AssistantTile(name: 'Ricardo Zambrano'),
          AssistantTile(name: 'Jordan González')
        ],
      ),
    );
  }
}
