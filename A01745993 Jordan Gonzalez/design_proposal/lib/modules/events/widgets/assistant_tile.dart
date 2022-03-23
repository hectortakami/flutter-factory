import 'package:flutter/material.dart';

class AssistantTile extends StatelessWidget {
  final String name;
  final bool assistance;
  const AssistantTile({Key? key, required this.name, required this.assistance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: Row(
        children: [
          const Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.black,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                name,
                style: const TextStyle(fontSize: 18),
              )),
          const Spacer(),
          assistance
              ? const Icon(
                  Icons.check,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.cancel,
                  color: Colors.black,
                )
        ],
      ),
    );
  }
}
