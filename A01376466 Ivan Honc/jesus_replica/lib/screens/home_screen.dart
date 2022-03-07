import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final PageController pageController = new PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0,
      ),

      // Cambiar la pantalla
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomScreen(color: Colors.white),
          CustomScreen(color: Color.fromARGB(255, 192, 175, 175)),
          CustomScreen(color: Color.fromARGB(255, 140, 141, 143)),
        ],
      ),
      //   Tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          currentPage = index;

          pageController.animateToPage(index,
              duration: Duration(milliseconds: 600), curve: Curves.bounceOut);

          setState(() {});
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue.withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'User'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_rounded), label: 'Cart'),
        ],
      ),
    );
  }
}

class CustomScreen extends StatelessWidget {
  final Color color;
  const CustomScreen({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text('Template'),
      ),
    );
  }
}
