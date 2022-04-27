import 'package:design_proposal/modules/events/screens/explore_events.dart';
import 'package:design_proposal/modules/events/screens/user_events.dart';
import 'package:design_proposal/modules/tickets/screens/all.dart';
import 'package:design_proposal/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _selectIndex(int index) => setState(() => {_currentIndex = index});

  Future<void> showEventForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController textEditingController =
              TextEditingController();

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
                      controller: textEditingController,
                      validator: (value) {
                        return value!.isEmpty ? 'Missing field' : null;
                      },
                      decoration: const InputDecoration(hintText: 'Event name'),
                    ),
                    const SizedBox(height: 18),
                    InputDatePickerFormField(firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+10)),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: textEditingController,  // add this line.
                      decoration: const InputDecoration(
                        labelText: 'Event Time',
                      ),
                      onTap: () async {
                        TimeOfDay time = TimeOfDay.now();
                        FocusScope.of(context).requestFocus(new FocusNode());
                  
                        TimeOfDay? picked = await showTimePicker(context: context, initialTime: time);
                        if (picked != null && picked != time) {
                          textEditingController.text = picked.toString();  // add this line.
                          setState(() {
                            time = picked;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'cant be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: textEditingController,
                      validator: (value) {
                        return value!.isEmpty ? 'Missing field' : null;
                      },
                      decoration:
                          const InputDecoration(hintText: 'Event description'),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: textEditingController,
                      validator: (value) {
                        return value!.isEmpty ? 'Missing field' : null;
                      },
                      decoration:
                          const InputDecoration(hintText: 'Location: State'),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: textEditingController,
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
                      if(formKey.currentState!.validate()) {
                        formKey.currentState!.save();
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
            ? FloatingActionButton(
                onPressed: () async {
                  await showEventForm(context);
                },
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.add),
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
