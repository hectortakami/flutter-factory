# Hello World

## Simple mobile application interface with a counter functionality

A clean and simple Flutter app with a built-in counter functionality.

The development of this project served as a "hello world" in the realm of Flutter to start checking all the different tools available.

## Getting Started

The key resources that were used for learning Flutter and develop the project:

- [Introduction to Flutter](https://youtube.com/playlist?list=PLCKuOXG0bPi1_ZY2c9LU7MvvtWk82x1wB)
- [Building a custom appbar on Flutter](https://www.youtube.com/watch?v=BAshFKJptFg&t=308s&ab_channel=JohannesMilke)
- [Animated counter package](https://pub.dev/packages/animated_counter)

## Requirements

Before starting you need to have the following resources installed:

- Install [VS Code](https://code.visualstudio.com/) with the [Flutter extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- Install [Flutter](https://docs.flutter.dev/get-started/install)

## Note
>I think is important to complete the installation package with Android Studio, because this one will give us the certainty of installing and running our app on a virtual device

## Building the app

On the path that we want to create the app we will open Visual Studio Code and do the following:

- Press *Ctrl+Shift+p* to open the command palette.
- Type *flutter new* and hit enter.

This will generate the boilerplate code for the Flutter project.

Once the project is generated you should navigate to the *main.dart* file and delete all the comments as well as the classes *MyHomePage* and *_MyHomePageState*.

You should be left with the following code:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

Now, you should have an error on this line:

```dart
home: const MyHomePage(title: 'Flutter Demo Home Page'),
```

Do not worry about it for now. We are going to start with a couple of things:

- Locate the *lib* directory where the main.dart file was created.
- Create a directory within *lib* called *screens*.
- On the newly created *screens folder* create a file named *couter_screen.dart*.
## Note
> counter_screen.dart instead of couter_screen.dart

Before we proceed with building the *counter_screen* we will add the only external dependency that we are going to use called *animated_counter*.
Navigate to the *pubspec.yaml* file on the project directory and add the following line to the dependencies:

```yaml
animated_counter: ^1.0.0
```

Your dependencies should look like this:

```yaml
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  animated_counter: ^1.0.0
```

Now we can continue; navigate to the *counter_screen.dart* file that we just created and copy the folling base stateful widget code:

## Note
> Following instead of folling

```dart
import 'package:flutter/material.dart';
import 'package:animated_counter/animated_counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
```

You may have noticed that we added two imports, the first one, *material*, is a comprehensive library that allows for an enhanced development of widgets within Flutter. The second one, *animated_counter*, includes a suite of easy to implement animated counters that we will be integrating in our project.

Now, we wil use for the animated counter a ticker mixin, so to use it we need to add *with TickerProviderStateMixin* on the class definition, it should look like this: 

```dart
class _CounterScreenState extends State<CounterScreen> with TickerProviderStateMixin {
```

Next, we need to declare our global variables on *_CounterScreenState*:

```dart
int counter = 0;
late CreatureCounter cre;
```

After that we need to override the initState mehtod to initialize our animated counter that we just declared *CreatureCounter cre*:

```dart
@override
void initState() {
    cre = CreatureCounter(
        vsync: this,
        initialCounter: counter,
        initialColors: [Colors.red, Colors.green, Colors.blue]);
    super.initState();
}
```

Now, we are going to focus on building our widget, we are going to delete the *return Container(color: const Color(0xFFFFE306));* and replace it with the following:

```dart
@override
Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(

        )
    );
}
```

We just created a *DefaultTabController* widget that allows us to create navbar with multiple tabs, we defined that it is going to have 4 tabs and that it has a *Scaffold* as a child.

Within the *Scaffold* we are going to create the appBar with the following code:

```dart
return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                title: const Text('Counter App'),
                elevation: 0,
                leading:
                    IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.notifications), onPressed: () {})
                ],
                bottom:
                    const TabBar(indicatorWeight: 4, isScrollable: true, tabs: [
                  Tab(
                    icon: Icon(Icons.ads_click),
                    text: "Counter",
                  ),
                  Tab(
                    icon: Icon(Icons.history),
                    text: "Saved Items",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Profile",
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: "Settings",
                  )
                ]))));
```

We just created the AppBar widget that adds the title, the icon buttons, and defined the 4 tabs of our *DefaultTabController*.

Now we will add the body of the widget which includes the counter text, the counter number and the counter animation:

```dart
return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                title: const Text('Counter App'),
                elevation: 0,
                leading:
                    IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.notifications), onPressed: () {})
                ],
                bottom:
                    const TabBar(indicatorWeight: 4, isScrollable: true, tabs: [
                  Tab(
                    icon: Icon(Icons.ads_click),
                    text: "Counter",
                  ),
                  Tab(
                    icon: Icon(Icons.history),
                    text: "Saved Items",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Profile",
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: "Settings",
                  )
                ])),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Clicks Counter',
                        style: TextStyle(fontSize: 30)),
                    Text('$counter',
                        style: counter < 0
                            ? const TextStyle(fontSize: 30, color: Colors.red)
                            : const TextStyle(
                                fontSize: 30, color: Colors.blue)),
                    SizedBox(
                        height: 450,
                        child: Stack(children: [cre.build(context)])),
                  ]),
            )));
```

The body has a widget called center just to center align the body, as a child it has a column that allow us to define the children row by row. Within the column we center the elements with the *mainAxisAlignment* property and we define the three children the title text, the counter text and a sizedbox that encapsulates our animated counter.

And to finalize this widget we are goint to create the buttons to increment and decrement the counter:

```dart
return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Counter App'),
            elevation: 0,
            leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            actions: [
              IconButton(
                  icon: const Icon(Icons.notifications), onPressed: () {})
            ],
            bottom: const TabBar(indicatorWeight: 4, isScrollable: true, tabs: [
              Tab(
                icon: Icon(Icons.ads_click),
                text: "Counter",
              ),
              Tab(
                icon: Icon(Icons.history),
                text: "Saved Items",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: "Settings",
              )
            ])),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Clicks Counter', style: TextStyle(fontSize: 30)),
                Text('$counter',
                    style: counter < 0
                        ? const TextStyle(fontSize: 30, color: Colors.red)
                        : const TextStyle(fontSize: 30, color: Colors.blue)),
                SizedBox(
                    height: 450, child: Stack(children: [cre.build(context)])),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                counter--;
                counter >= 0 ? cre.decrementCounter() : null;
                setState(() {});
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                counter++;
                counter > 0 ? cre.incrementCounter() : null;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
```

We defined the location of the floatingActionButton and we created two buttons and mapped them to the counter logic just to add or decrease the counter; also we are calling the integrated functions for incrementing and decrementing the animated counter.

This is all the code needed for the *counter_screen.dart* file and it should look like this:

```dart
import 'package:flutter/material.dart';
import 'package:animated_counter/animated_counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with TickerProviderStateMixin {
  int counter = 0;
  late CreatureCounter cre;

  @override
  void initState() {
    cre = CreatureCounter(
        vsync: this,
        initialCounter: counter,
        initialColors: [Colors.red, Colors.green, Colors.blue]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Counter App'),
            elevation: 0,
            leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
            actions: [
              IconButton(
                  icon: const Icon(Icons.notifications), onPressed: () {})
            ],
            bottom: const TabBar(indicatorWeight: 4, isScrollable: true, tabs: [
              Tab(
                icon: Icon(Icons.ads_click),
                text: "Counter",
              ),
              Tab(
                icon: Icon(Icons.history),
                text: "Saved Items",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: "Settings",
              )
            ])),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Clicks Counter', style: TextStyle(fontSize: 30)),
                Text('$counter',
                    style: counter < 0
                        ? const TextStyle(fontSize: 30, color: Colors.red)
                        : const TextStyle(fontSize: 30, color: Colors.blue)),
                SizedBox(
                    height: 450, child: Stack(children: [cre.build(context)])),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                counter--;
                counter >= 0 ? cre.decrementCounter() : null;
                setState(() {});
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                counter++;
                counter > 0 ? cre.incrementCounter() : null;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

And the last thing we need to change is in the *main.dart* file, we need to fix the error that we encountered at the start, we need to import the widget that we just created and return it, so your file should look like this:

```dart
import 'package:flutter/material.dart';
import 'package:hello_world/screens/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: CounterScreen());
  }
}
```

## We are ready to run our app

To run the app we need to:

- Press *Ctrl+Shift+p* to open the command palette.
- Type *flutter select device* and hit enter.
- Select the device of your choosing.
- Press F5 and wait until the project finishes compiling and you should be able to see your app.

## Sneak peek of the app
![Counter 0](https://user-images.githubusercontent.com/100311454/156825193-075a097c-dcd5-4c3e-9dbf-9bd441be9bee.jpg)
![Counter -2](https://user-images.githubusercontent.com/100311454/156825195-745c63c8-0771-4407-a517-777cce6797bb.jpg)
![Counter 5](https://user-images.githubusercontent.com/100311454/156825197-e7bb028b-16ea-4cd6-95ca-ce95ea5d2343.jpg)
## Note
>We wouldn't be able to see those screens because we don't have an emulator, we will be watching the same functionality on the internet instead of a virtual device.

![prueba_ivan](https://user-images.githubusercontent.com/30931599/157369864-ab3fb038-fb37-4588-8ab7-65e9fb9a018d.JPG)
>This is how it looks like really.
