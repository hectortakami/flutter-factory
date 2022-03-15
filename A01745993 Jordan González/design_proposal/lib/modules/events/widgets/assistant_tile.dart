import 'package:flutter/material.dart';

class AssistantTile extends StatelessWidget {
  final String name;
  const AssistantTile({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.black,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                this.name,
                style: TextStyle(fontSize: 18),
              )),
          Spacer(),
          Icon(
            Icons.check,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
