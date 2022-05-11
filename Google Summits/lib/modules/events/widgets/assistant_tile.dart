import 'package:design_proposal/models/ticket.dart';
import 'package:flutter/material.dart';

class AssistantTile extends StatelessWidget {
  final Ticket ticket;
  const AssistantTile({Key? key, required this.ticket}) : super(key: key);

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
                '${ticket.holder['name']} ${ticket.holder['lastname']}',
                style: const TextStyle(fontSize: 18),
              )),
          const Spacer(),
          ticket.attendance
              ? const Icon(
                  Icons.check,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.black,
                )
        ],
      ),
    );
  }
}
