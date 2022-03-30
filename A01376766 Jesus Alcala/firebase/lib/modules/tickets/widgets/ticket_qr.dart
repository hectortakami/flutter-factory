import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/ticket.dart';

class TickerQr extends StatelessWidget {
  final Ticket ticket;

  const TickerQr({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: 'Ticket ID: ${ticket.uid}\nEvent ID: ${ticket.eventId}\nEvent Name: ${ticket.eventName}\nLocation: ${ticket.location['state']}, ${ticket.location['city']}',
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
