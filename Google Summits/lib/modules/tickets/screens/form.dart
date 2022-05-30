import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/models/ticket.dart';
import 'package:design_proposal/modules/core/widgets/text_form_field.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/services/tickets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketForm extends StatefulWidget {
  final Event? event;
  const TicketForm({Key? key, this.event}) : super(key: key);

  @override
  State<TicketForm> createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Event? event = widget.event;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final auth =
                        Provider.of<AuthProvider>(context, listen: false);
                    final TicketsService ticketsService = TicketsService();

                    final Ticket fbTicket = Ticket(
                        eventUid: event!.uid!,
                        userUid: auth.user!.uid,
                        attendance: false,
                        holder: {
                          'name': nameController.text,
                          'lastname': lastnameController.text
                        });

                    if (fbTicket == null) {
                      ticketsService.setTicket(fbTicket);
                    } else {
                      ticketsService.addTicket(fbTicket);
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])))
          ],
          title: const Text('Add ticket',
              style: TextStyle(color: Colors.black, fontFamily: 'ProductSans')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          labelText: 'Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert the name';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: lastnameController,
                          labelText: 'Lastname',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert the lastname';
                            }
                            return null;
                          },
                        ),
                      ])),
            ],
          ),
        ));
  }
}
