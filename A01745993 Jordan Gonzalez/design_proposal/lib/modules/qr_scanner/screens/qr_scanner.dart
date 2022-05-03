import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/models/ticket.dart';
import 'package:design_proposal/services/tickets.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  final Event? event;
  const QrScanner({Key? key, this.event}) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>
    with SingleTickerProviderStateMixin {
  String? barcode;
  final TicketsService ticketsService = TicketsService();

  void _handleOnDetect(Barcode _barcode, MobileScannerArguments? args) async {
    setState(() {
      this.barcode = _barcode.rawValue;
    });
    print(_barcode.rawValue);
    print(barcode);

    try {
      Ticket ticket = await ticketsService.getTicket(barcode!);
      if (ticket.attendance == false) {
        ticketsService.setAttendance(ticket);
        Navigator.pop(context);
      } else {
        print('user already in event');
      }
    } catch (e) {
      print('ticket doesnt exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    Event? event = widget.event;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(event != null ? event.name : 'Ticket Scanner'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            MobileScanner(
                fit: BoxFit.cover,
                // allowDuplicates: false,
                onDetect: _handleOnDetect),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 1 / 6,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: Text(barcode ?? 'Scanning...',
                              overflow: TextOverflow.fade,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
