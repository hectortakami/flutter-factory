# flutter_application_1

## Counter App

Se pretende hacer un primer acercamiento a el uso del lenguaje de **Flutter** para desarrollar un proyecto en colaboración con **Google**. A01745993 - Typo, mayúsculas.

Desarrollaremos a lo largo de este documento la elaboración de una app sencilla con un contador, un poco "tuneada" con diferentes secciones.

## Requisitos

---

> - Instala [VS Code](https://code.visualstudio.com/).
> - Instalar [Flutter](https://docs.flutter.dev/get-started/install).
> - Instalar [Android Studio](https://docs.flutter.dev/get-started/install). Dentro de Android Studio es necesario instalar un <a href="C:\Users\joscu\Desktop\10mo semestre\Proyecto integrador\emulador.png">emulador</a>![emulador](https://user-images.githubusercontent.com/30931599/156466283-35f5533c-942a-4850-a613-4cb62fb38c59.png)

##Empecemos...

Dentro de VS Code con la extensión de flutter y Dart instalada (Les dejo aquí un link sobre lo que es [Dart](https://dart.dev/)) iniciaremos un nuevo proyecto de flutter usando los comandos.
`ctrl + p` > `flutter new project` > `Aplicacion` > `"folder donde estara el proyecto"` > `Nombre de proyecto` > `enter`

Después se generaran varios folders con todas las dependencias de flutter dentro de VS Code, dentro del folder **lib** encontraremos un programa llamado `main.dart` el cual será nuestro principal objetivo dentro de todo este desarollo.

## 1. Main.dart

Iniciamos el programa y eliminamos todo el código generado por default dentro de `main.dart` y lo reemplazamos por :

```
import 'package:flutter/material.dart';
```

- Importamos el paquete de flutter que contiene todo el material que utilizaremos para los widgets

```dart
import 'package:[NOMBRE DE PROYECTO]/screens/counter_screen.dart'; // A01745993 - Indicamos que el usuario debe importar según el nombre de su proyecto
```

- Importamos la ruta de nuestros archivos con la **ruta absoluta** dentro de nuestro archivo _counter_screen_

```dart
//import 'package:[NOMBRE DE PROYECTO]/screens/home_screen.dart';
```

- Importación de la ruta abolsuta sobre el 1er archivo funcional **comentada** porque no se usa

```dart
void main() {
  runApp(const MyApp());
}
```

- Función que le señala a Dart donde **empieza** el programa, así como ejecutar el contructor de _MyApp()_

```dart

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
```

- Separamos todo en clases explicitas con funcionamiento donde se declaran **variables/propiedades**, así como en este caso usar un _Stateless widget_ que quiere decir, un widget estatico que no sufre cambios.
  > Todas las clases extienden de un Stateless o Stateful widget
  >
  > > El tipo de variable "const" es cuando un valor no cambiará y se sabe en tiempo de compilación

```dart

  @override
  Widget build(BuildContext context)
```

- El método _@override_ es un método que transforma un método abstracto en concreto par definirlo.
- Presenta un conjunto de métodos que se pueden usar desde los métodos [StatelessWidget.build](https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html) y desde los métodos en los objetos [State](https://api.flutter.dev/flutter/widgets/State-class.html). los cuales. cada widget tiene su propio BuildContext, que se convierte en el padre del widget devuelto por la función [StatelessWidget.build](https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html) o [State.build](https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html)

```dart
  {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        //home: HomeScreen()
        home: const CounterScreen());
  }
}
```

- Los cambios de color son arbitrarios con la infinidad de tipos que hay, este caso seleccione el morado porque es mi color favorito dentro de `theme: themeData()`
- `debugShowCheckedBanner: false` sirve para quitar un mensaje que sale en la parte superior derecha de tu emulador cuando corres la app
- `home: const CounterScreen()` la ruta de que archivo se ejecutará.

Completo el programa se vería asi:

```dart
import 'package:flutter/material.dart';
import 'package:[NOMBRE DE PROYECTO]/screens/counter_screen.dart';
import 'package:[NOMBRE DE PROYECTO]/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        //home: HomeScreen()
        home: const CounterScreen());
  }
}
```

## 2.Creación de folder `screens`

Dentro del folder `lib` crearemos un nuevo folder llamado _screens_ el cual contendrá a nuestros nuevos archivos `home_screen` y `counter_screen` los cuales serán editados con lo necesario para tener la funcionalidad que buscamos.

## 3. home_screen base

Este archivo fue util para saber bastantes cosas sobre _widgets_ y funcionalidades en **flutter**

```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(Set set, {Key? key}) : super(key: key);

  //variable, propiedad

  @override
  Widget build(BuildContext context) {
    const fontSize30 = TextStyle(fontSize: 30);
    int counter = 10;
```

- Dentro de este espacio se declaran _variables_ o _propiedades_ de las clases que se usaran.

```dart
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        elevation: 0,
      ),
      body: Center(
```

- `Scaffold` Implementa la estructura de disposición visual básica del diseño de materiales.
- `appBar` Una barra de aplicaciones para mostrar en la parte superior del `Scaffold`.
- `body` El contenido principal del `Scaffold`.
- `title` Una descripción de una línea utilizada por el dispositivo para identificar la aplicación para el usuario.
- `Center` alinea su _widget_ secundario con el centro del espacio disponible en la pantalla.

```dart
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Numero de tabs',
              style: fontSize30,
            ),
            Text(
              '$counter',
              style: fontSize30,
            ),
          ],
        ),
      ),
```

- `child` toma un solo _widget_
- `mainAxisAlignment` Cómo se deben colocar los `child` a lo largo del eje principal.
- `children` toma una lista de _widgets_
- `Text` Mostrar y estilo de texto _widget_.

```dart
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
```

- `floatingActionButton` Un botón de acción flotante es un botón de icono circular que se desplaza sobre el contenido para promover una acción principal en la aplicación. Los botones de acción flotantes se usan más comúnmente en el campo [Scaffold.floatingActionButton.](https://api.flutter.dev/flutter/material/Scaffold/floatingActionButton.html)

```dart
        child: const Icon(Icons.add),
        onPressed: () {
```

- `onPressed()` una acción de presionar un botón y ejecutar una función usando la propiedad onPressed.

```dart
          print('Hola mundo');
          counter++;
        },
      ),
    );
  }
}
```

Completo el programa se vería asi:

```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(Set set, {Key? key}) : super(key: key);

  //variable, propiedad

  @override
  Widget build(BuildContext context) {
    const fontSize30 = TextStyle(fontSize: 30);
    int counter = 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Numero de tabs',
              style: fontSize30,
            ),
            Text(
              '$counter',
              style: fontSize30,
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print('Hola mundo');
          counter++;
        },
      ),
    );
  }
}
```

## 4. Nuestra App

Realizaremos un `ctrl + c` y `ctrl + v` para poder tener el mismo contenido dentro de **counter_screen** para solo editar ciertos campos correspondientes

```dart
import 'package:flutter/material.dart';
import 'package:[NOMBRE DE PROYECTO]/screens/home_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}
```

- El `state` es información que (1) se puede leer sincrónicamente cuando se crea el _widget_ y (2) puede cambiar durante la vida útil del _widget_. Es responsabilidad del implementador del _widget_ asegurarse de que el `state` sea notificado de inmediato cuando dicho estado cambie, utilizando [State.setState](https://api.flutter.dev/flutter/widgets/State/setState.html).

```dart

class _CounterScreenState extends State<CounterScreen> {
  //variable, propiedad
  int counter = 10;
```

- Lugar donde se definen globalmente las _variables_ y _propiedades_.

```dart

  @override
  Widget build(BuildContext context) {
    const fontSize30 = TextStyle(fontSize: 30);

    return Scaffold(
        //Button Section
        appBar: AppBar(
          title: const Text('CounterScreen'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/Ticket.jpg')),
```

- Definido mas adelante en este docs sobre lo que es el (A01745993 - Typo en que)
- `image` Un _widget_ que muestra una imagen.

```dart
              const Text(
                'Numero de tabs',
                style: fontSize30,
              ),
              Text(
                '$counter',
                style: fontSize30,
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code),
```

- En nuestro proyecto cambiamos el tipo de icono a un `qr.code`

```dart
          onPressed: () {
            counter++;
            setState(() {});
          },
        ));
  }
}
```

Completo el programa se vería así:

```dart
import 'package:flutter/material.dart';
import 'package:[NOMBRE DE PROYECTO]/screens/home_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  //variable, propiedad
  int counter = 10;

  @override
  Widget build(BuildContext context) {
    const fontSize30 = TextStyle(fontSize: 30);

    return Scaffold(
        //Button Section
        appBar: AppBar(
          title: const Text('CounterScreen'),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/Ticket.jpg')),
              const Text(
                'Numero de tabs',
                style: fontSize30,
              ),
              Text(
                '$counter',
                style: fontSize30,
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code),
          onPressed: () {
            counter++;
            setState(() {});
          },
        ));
  }
}
```

## 5.assets

```dart
const Image(image: AssetImage('assets/Ticket.jpg')),
```

Nos encargamos de crear un nuevo folder llamado _assets_ el cual contiene dentro del mismo una imagen que nos sirve para cargar dentro de nuestra app.
Para esto se tuvo que editar el archivo [pubspec.yaml](https://docs.flutter.dev/development/tools/pubspec) dentro del proyecto.

## 6. Proyecto terminado

![Screenshot_1646106106](https://user-images.githubusercontent.com/30931599/156466242-ecc622da-75a8-4197-b4d2-6939bd5a11a1.png)

## Otras referencias

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Playlist sobre aplicaciones en flutter](https://www.youtube.com/watch?v=mTErlB_wT6A&list=PLCKuOXG0bPi1_ZY2c9LU7MvvtWk82x1wB)

- [Online documentation](https://flutter.dev/docs)

A01745993 - Pude terminar la aplicación y resultó como en el screenshot final. Realicé cambios mínimos en Typos y añadí la palabra reservada `dart` después de abrir cada bloque de código, pues así podemos ver una mejor decoración del código.
