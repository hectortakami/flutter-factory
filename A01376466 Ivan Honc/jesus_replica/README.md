# Page controller app

Tutorial app for learning flutter

Created on Windows
---

## Requisites

Get the [Flutter SDK](https://docs.flutter.dev/get-started/install/windows)

Update your path adding flutter /bin file

Run flutter doctor with the comand >flutter doctor on the terminal

Install [VS code](https://code.visualstudio.com/)

Install [Android Studio](https://developer.android.com/studio?hl=es-419&gclid=Cj0KCQiA64GRBhCZARIsAHOLriIRgsLDUTYpKi5d-BQKNVDQA8JwafFQ03BCqxMbu-VpAw8gkruIYVYaAlI-EALw_wcB&gclsrc=aw.ds) and an Android Studio emulator
---
## Create a new app

1. Use the command `ctrl+shift+p` and start writing flutter
2. Select the "New Application project option"
3. Name your app

---

## Verify if the template app is running

1. Use the command `ctrl+shift+p` and start writing flutter
2. Select the launch emulator option
3. Press `f5` to run the app


---

## Edit the template app
 
1. delete all code in "main.dart" file
2. start writing mateapp and select the first option  A01376466 - I did not understand this line.
the new code should look like this:
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
```
#### Notes:

Scaffold: White canvas  with the screen size

90% of flutter elements are widgets

In this code the body searchs for the child to apply the center widget


### More editing to the template app

The new code should look like this:
```dart
import 'package:flutter/material.dart';

import 'package:base_flutter/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola mundo',
        theme: ThemeData.light(),
        home: HomeScreen());
  }
}

```
#### Changes made and more notes:

First we import the new screen that we will add at a new file named `screens` inside `lib` named "home_screen.dart" A01376466 - Screens is a folder, not a file.

We remove de "debug" banner

Change the way of declaring thhe appbar and add a theme to it at `theme` 

Extend the widget at the other screen(home_screen.dart)


#### Add content to the `home_screen.dart`

statefull widget:
```dart
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
```
Declare the state of the homeScreen and the page controller:
```dart
class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final PageController pageController = new PageController(initialPage: 1);
```
Create the appbar with the theme previously selected:
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0,
      ),
```
Do the logic that allows to change to the selected page(here we select the background color of each page):
```dart
body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomScreen(color: Colors.white),
          CustomScreen(color: Color.fromARGB(255, 192, 175, 175)),
          CustomScreen(color: Color.fromARGB(255, 140, 141, 143)),
        ],
      ),
```
Create the navigation bar(here we select the icons of each navigation item, the animation duration and curve displayed , the color of each icon and the color of the navigation bar):
```dart
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
```
Add the stateless widget, content to the scaffold, create a container and center the child: A01376466 - It wasn't very clear what scaffold you are talking about.
```dart
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
```
---
### Final code should look like this
#### `main.dart`
```dart
import 'package:flutter/material.dart';

import 'package:base_flutter/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola mundo',
        theme: ThemeData.light(),
        home: HomeScreen());
  }
}

```
### `home_screen.dart`
```dart
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

```
---
### If you run the app on the emulator it should look like this:
[![pagechanger.png](https://i.postimg.cc/XvpDmgKK/pagechanger.png)](https://postimg.cc/CZpNfkQd)


---
Sources:

[Flutter](https://flutter.dev/)

[Icons](https://api.flutter.dev/flutter/material/Icons-class.html)

Retrieved from [Fernando Herrera](https://www.youtube.com/channel/UCuaPTYj15JSkETGnEseaFFg) Youtube tutorials

A01376466 - I was able to complete the application, just a few minor issues were found in the documentation.
