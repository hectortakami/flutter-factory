import 'package:design_proposal/modules/tickets/widgets/ticket_qr.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({Key? key}) : super(key: key);

  dynamic _showQrDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: SimpleDialog(
                title: Text('Event Name'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TickerQr(),
                    ),
                  ),
                ],
                elevation: 5,
                //backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 1),
        child: GestureDetector(
          onTap: () => _showQrDialog(context),
          child: Card(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 12, bottom: 12, right: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: Colors.grey,
                          size: 36,
                        ),
                        Padding(padding: EdgeInsets.only(right: 8)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Event name',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'ProductSans')),
                            Text(
                              'Location',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('day'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('time'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
