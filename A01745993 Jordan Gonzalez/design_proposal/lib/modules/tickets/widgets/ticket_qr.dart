import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TickerQr extends StatelessWidget {
  const TickerQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: 'Ticket key/id/whatever goes here',
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }
}
