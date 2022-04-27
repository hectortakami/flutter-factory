import 'package:design_proposal/modules/events/screens/explore_events.dart';
import 'package:design_proposal/modules/events/screens/user_events.dart';
import 'package:design_proposal/modules/qr_scanner/screens/qr_scanner.dart';
import 'package:design_proposal/modules/tickets/screens/all.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event.dart';
import '../services/events.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final eventService = EventsService();

  void _selectIndex(int index) => setState(() => {_currentIndex = index});

  Future<void> showEventForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          TextEditingController nameController = TextEditingController();
          TextEditingController dateController = TextEditingController();
          TextEditingController timeController = TextEditingController();
          TextEditingController descriptionController = TextEditingController();
          TextEditingController stateController = TextEditingController();
          TextEditingController cityController = TextEditingController();

          return AlertDialog(
              content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Event Form',
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'ProductSans'),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Event name'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: dateController,
                          decoration:
                              const InputDecoration(hintText: "Event date"),
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
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: timeController,
                          decoration: const InputDecoration(
                            labelText: 'Event time',
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay time = TimeOfDay.now();
                            TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: time);

                            if (pickedTime != null) {
                              var formattedHour =
                                  pickedTime.hour.toString().length < 2
                                      ? "0" + pickedTime.hour.toString()
                                      : pickedTime.hour.toString();
                              var formattedMinute =
                                  pickedTime.minute.toString().length < 2
                                      ? "0" + pickedTime.minute.toString()
                                      : pickedTime.minute.toString();

                              setState(() {
                                timeController.text =
                                    formattedHour + ":" + formattedMinute;
                              });
                            }
                          },
                          validator: (value) {
                            value!.isEmpty ? 'Missing field' : null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: descriptionController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Event description'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: stateController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Location: State'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: cityController,
                          validator: (value) {
                            return value!.isEmpty ? 'Missing field' : null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Location: City'),
                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final auth =
                            Provider.of<AuthProvider>(context, listen: false);
                        auth.user!.uid;
                        DateTime dt = DateTime.parse(dateController.text +
                            " " +
                            timeController.text +
                            ":00");
                        TimeOfDay time = TimeOfDay.now();

                        final Event event = Event(
                            name: nameController.text,
                            description: descriptionController.text,
                            date: dt,
                            address: {
                              "city": cityController.text,
                              "state": stateController.text
                            },
                            ownerUid: auth.user!.uid);

                        eventService.addEvent(event);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Create Event'))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    String profilePicture = "";

    final auth = Provider.of<AuthProvider>(context);

    if (auth.user != null && auth.user!.photoUrl!.isNotEmpty) {
      profilePicture = auth.user!.photoUrl!;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Google Summits',
            style: TextStyle(color: Colors.grey, fontFamily: 'ProductSans'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => _buildUserMenuBottomSheet(context),
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  profilePicture,
                  scale: 0.1,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 4)),
          ],
          leading: IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.menu, color: Colors.black, size: 24),
          ),
        ),
        floatingActionButton: _currentIndex == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'add-participant',
                    onPressed: () async => await showEventForm(context),
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.blueAccent,
                  ),
                  Padding(padding: const EdgeInsets.only(left: 8)),
                  FloatingActionButton(
                    heroTag: 'scan-ticket',
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => QrScanner()))
                    },
                    child: const Icon(Icons.qr_code),
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
              )
            : Container(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: _selectIndex,
          elevation: 10,
          currentIndex: _currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Colors.blueAccent,
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.event, color: Colors.blueAccent),
                icon: Icon(Icons.event, color: Colors.grey),
                label: 'Events'),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                label: 'Explore'),
            BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.confirmation_number, color: Colors.blueAccent),
                icon: Icon(Icons.confirmation_number_outlined,
                    color: Colors.grey),
                label: 'Tickets'),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [const UserEvents(), ExploreEvents(), Tickets()],
        ));
  }

  void _buildUserMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final auth = Provider.of<AuthProvider>(context);

          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ListTile(
                title: const Text('Log out'),
                onTap: () => {
                  Navigator.pop(context),
                  auth.signOut(),
                },
              ),
              const ListTile(
                title: Text(''),
              ),
              const Divider(
                color: Colors.transparent,
              )
            ],
          );
        });
  }
}
