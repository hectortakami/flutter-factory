import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/ticket.dart';

class TickerQr extends StatelessWidget {
  final Ticket ticket;

  const TickerQr({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: ticket.uid,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
