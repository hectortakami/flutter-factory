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

  void _selectIndex(int index) => setState(() => {_currentIndex = index});

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
        floatingActionButton: _currentIndex == 1
            ? FloatingActionButton(
                onPressed: () => {},
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
