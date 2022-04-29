import 'package:design_proposal/models/event.dart';
import 'package:design_proposal/modules/core/widgets/text_form_field.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:design_proposal/services/events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  final Event? event;
  const EventForm({Key? key, this.event}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    Event? event = widget.event;
    nameController.text = event != null ? event.name : '';
    descriptionController.text = event != null ? event.description : '';
    dateController.text = event != null
        ? '${event.date.year}-${event.date.month.toString().padLeft(2, '0')}-${event.date.day.toString().padLeft(2, '0')}'
        : '';
    timeController.text = event != null
        ? '${event.date.hour}:${event.date.minute.toString().padRight(2, '0')}'
        : '';
    stateController.text = event != null ? event.address['state'] : '';
    cityController.text = event != null ? event.address['city'] : '';

    super.initState();
  }

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
                    final eventService = EventsService();

                    DateTime dt = DateTime.parse(dateController.text +
                        " " +
                        timeController.text +
                        ":00");
                    TimeOfDay time = TimeOfDay.now();

                    final Event fbEvent = Event(
                        uid: event?.uid,
                        name: nameController.text,
                        description: descriptionController.text,
                        date: dt,
                        address: {
                          "city": cityController.text,
                          "state": stateController.text
                        },
                        ownerUid: auth.user!.uid,
                        isPublic: true);

                    if (event != null) {
                      eventService.setEvent(fbEvent);
                    } else {
                      eventService.addEvent(fbEvent);
                    }
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  }
                },
                child: Text(event != null ? 'Update' : 'Save',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])))
          ],
          title: Text(event != null ? 'Edit event' : 'Create event',
              style: const TextStyle(
                  color: Colors.black, fontFamily: 'ProductSans')),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
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
                          controller: descriptionController,
                          labelText: 'Description',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert a description';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: dateController,
                          labelText: 'Date',
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 10));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                dateController.text = formattedDate;
                              });
                            }
                          },
                          validator: (value) {
                            value!.isEmpty ? 'Missing field' : null;
                          },
                        ),
                        CustomTextFormField(
                          controller: timeController,
                          labelText: 'Time',
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay time = TimeOfDay.now();
                            TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: time);

                            if (pickedTime != null) {
                              String formattedHour =
                                  pickedTime.hour.toString().length < 2
                                      ? "0" + pickedTime.hour.toString()
                                      : pickedTime.hour.toString();
                              String formattedMinute =
                                  pickedTime.minute.toString().length < 2
                                      ? "0" + pickedTime.minute.toString()
                                      : pickedTime.minute.toString();

                              setState(() {
                                timeController.text =
                                    formattedHour + ":" + formattedMinute;
                              });
                            }
                          },
                        ),
                        CustomTextFormField(
                          controller: stateController,
                          labelText: 'State',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'State location is required';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: cityController,
                          labelText: 'City',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'City location is required';
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
