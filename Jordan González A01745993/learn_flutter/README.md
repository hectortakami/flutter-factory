# Simple Counter App

A simple Flutter project for a Counter App.

This project will help you learn some of the basics of the framework and the Dart programming language.

Disclaimer: the commands described in this documentation are targeted for any UNIX-based Operative System. For Windows, use the PowerShell.

## Pre-requisites

---

1. Install [Flutter](1).
2. [Set up](2) an editor.
3. Run the following command and ensure everything in the output is checked.

```zsh
flutter doctor
```

## Create the app

---

In order to create our app, it is necessary to generate a boilerplate for us to start coding.

### 1. Generate boilerplate app.

---

Open a terminal in the desired folder of destination and run the following commands:

```zsh
flutter create counter_app
cd counter_app
```

Once everything is created, open the generated folder `counter_app/lib` in your editor of preference and remove every comment, and the classes: `MyHomePage` and `_MyHomePageState`.

Rename the class `MyApp` to `CounterApp`, and every reference to it.

The code in `main.dart` should look like this:

```dart
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Rename this title to Counter App
      theme: ThemeData(
        primarySwatch: Colors.blue, // Try changing the color
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // This line should be marked as an error since we deleted the class.
    );
  }
}
```

### 2. Make screens folder, and create home screen.

---

In your terminal, run the following commands in the app directory:

```zsh
mkdir screens
cd screens
touch home.dart
```

Open `home.dart` in your editor and add the following boilerplate code for a [Stateful Widget](3).

```dart
// home.dart
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
```

To reference our new Home screen, in `main.dart` in the `lib` folder, we change the `home` parameter in the `MaterialApp` widget, and add an import, like the following:

```dart
// main.dart
...
import 'package:counter_app/screens/home.dart'; // Importing below the material package.

...
  ...
    return MaterialApp(
      title: 'Counter App', // Renaming the title.
      ...,
      home: const Home(), // Adding a reference to our new Home class
    );
  ...
```

If you try running the app in this stage, it will show a blank screen.

### 3. Add counter, and related functions

---

A stateful widget allows us to modify data on the go, allowing re-rendering with new data. The function `setState(() {})` is mainly used for that.

At the beginning of the class `_HomeState`, add the following lines to manage our counter:

```dart
// home.dart
...
class _HomeState extends State<Home> {
  int counter = 0; // The counter per se.

  void restartCounter() => setState(() => {counter = 0}); // A function that returns nothing but restarts the counter setting it with the setState function.
  void addToCounter(int number) => setState(() => {counter += number}); // A function that returns nothing but adds a given integer number to the counter.
  ...
}
```

Take in consideration in the example above, we are using arrow syntax to reduce the space taken by the [function](4), since they are pretty much self-descriptive.

### 4. Add scaffolding widgets, and main body.

---

In order to display something in screen, we need to add the `Scafold` widget, which essentially serves as a main directive to place common elements in a mobile app, such as: a bottom navigation bar; an app bar; and, a body; amongst others.

Inside our `Scaffold` widget, we will add the following:

An `AppBar` widget in the `appBar` parameter:

```dart
AppBar(
  title: const Text('Counter App'),
),
```

A set of widgets nested within each other to display our counter in the `body` parameter:

```dart
Center( // Center to the middle, X axis.
  child: Column( // This widget allows us to have multiple widgets in the Y axis.
    mainAxisAlignment: MainAxisAlignment.center, // Center in the Y axis.
    children: [
      const Text(
        'Current counter:',
        style: TextStyle(fontSize: 24), // We could avoid repeating code by declaring this style in a constant.
      ),
      Text(
        '$counter', // Formating text, an anternative could be: counter.toString()
        style: TextStyle(fontSize: 24),
      )
    ],
  ),
),
```

And finally, our buttons to substract, add, and reset our counter. There are multiple ways of doing this, but we will use the `floatingActionButton` parameter with the following widget:

```dart
Padding(
  padding: const EdgeInsets.all(8.0), // Adding 8 px padding.
  child: Row( // Add multiple widgets in the X axis.
    mainAxisAlignment: MainAxisAlignment.spaceAround, // Adding spacing between our buttons.
    children: <Widget>[
      FloatingActionButton(
        onPressed: () => addToCounter(-1), // Using our previously declared function adding a -1.
        child: Icon(Icons.exposure_minus_1), // Adding a button related to the content, in this case substracting.
      ),
      FloatingActionButton(
        onPressed: restartCounter, // Passing directly the function, since we don't send any parameters.
        child: Icon(Icons.restart_alt),
      ),
      FloatingActionButton(
        onPressed: () => addToCounter(1),
        child: Icon(Icons.plus_one),
      )
    ],
  ),
),
```

Our `_HomeState` class should look like the following:

```dart
// home.dart
...
class _HomeState extends State<Home> {
  int counter = 0;

  void restartCounter() => setState(() => {counter = 0});
  void addToCounter(int number) => setState(() => {counter += number});

  @override
  Widget build(BuildContext context) {
    const fontSize24 = TextStyle(fontSize: 24);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        elevation: 0, // Removing shadow in the AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current counter:',
              style: fontSize24,
            ),
            Text(
              '$counter',
              style: fontSize24,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Adding a location to our buttons.
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => addToCounter(-1),
              child: Icon(Icons.exposure_minus_1),
            ),
            FloatingActionButton(
              onPressed: restartCounter,
              child: Icon(Icons.restart_alt),
            ),
            FloatingActionButton(
              onPressed: () => addToCounter(1),
              child: Icon(Icons.plus_one),
            )
          ],
        ),
      ),
    );
  }
```

### 5. Verify functionality

---

Our app should be completed and should look like this:

[HERE GOES A PHOTO].

Try adding more functionality!
If you explore the code int he repo, you will notice that I've added a widget to show a bottom sheet, this is triggered as an action in the `AppBar`.

Learn more about this bottom sheet widget in the integrated function `showModalBottomSheet`, which you can check [here](5).

[1]: https://docs.flutter.dev/get-started/install
[2]: https://docs.flutter.dev/get-started/editor
[3]: https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html
[4]: https://dart.dev/guides/language/language-tour#functions
[5]: https://api.flutter.dev/flutter/material/showModalBottomSheet.html
