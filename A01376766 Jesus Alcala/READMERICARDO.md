# flutter_application_1 (Se replicó el proyecto pero al ser el contador default de flutter sin cambios no creí que fuera necesario subir la réplica)

# Introducción

Inicialmente cuando se crea un ambiente de flutter para el desarrollo de una aplicación, automaticamente se crea una aplicación de demo, que es un contador. Nuestra tarea para la semana fue replicar esta aplicación siguiendo un tutorial de flutter básico. 


# Requisitos para flutter

1. Se necesita descargar el sdk de flutter.
2. Se necesita descargar el sdk de Android. 
3. En caso de usar una comptudtadora Apple se tienes que instalar xcode. 
4.Es necesario descargar un simulador de los dispositivos en los que se quiera probar la aplicación. 

# Pasos para la instalación del sdk de flutter para VS Code en Windows.

1. Descarga del sdk de Flutter
2. Una vez que se descarga se tiene que cambiar el path de binarios en windows para poder usar flutter en la terminal. 
3. Es necesario descargar Android Studio para tener el sdk de Android y el simulador de algun dispositivo Android. 
4. Para VS Code es necesario instalar la extensión de Flutter que también instalará el soporte de dart y configurará el IDE para desarrollar de manera más sencilla con hints y ayudas por parte de la extensión.

5. Escribiendo el comando "flutter doctor" podremos ver si tenemos todo lo necesario para comenzar a programar en flutter. Hay cosas que no son completamente necesarias, por ejemplo no es necesario utilizar Visual Studio sino se quiere desarrollar software nativo para Windows. 

6. Una vez que ya están marcadas todas las cosas que necesitamos podemos comenzar a usar VS Code para programar. 


A01376766 Notas: 
1. Poner los links de descarga necesarios.
2. Detallar un poco más la parte del path en caso de que la persona que siga los pasos no tenga tanto conocimiento.
3. Escribir los casos que pueden no estár "tachados" al correr el comando flutter doctor y posibles soluciones.

# Crear una aplicación de flutter

1. Abrir la consola de windows, puede ser CMD o Powershell. 
2. Crear una carpeta donde vamos a ubicar nuestro proyecto. 
3. Abrir la carpeta del proyecto en la temrinal y correr el comando "flutter creat <nombre de la aplicación>"

Esto va a hacer el setup y la creación de todos los archivos para una aplicación de flutter. Inicialmente esto crea una aplicacón de contador sencilla, con un campo de texto que muestra la cantidad que hay en el contador y un botón para agregar una unidad al contador. 

Automaticamente flutter va a crear un main dentro de la carpeta de lib, donde va a estar funcionando la aplicación inicial. 



# Crear un main

Inicialmente podemos borrar todo lo que viene en el main generado por flutter. 

El archivo de main.dart debería ser similar a algo como esto: 

```dart

//Archivos que se estan importando para el funcionamiento correcto de la aplicación. 

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/counter_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

//Main donde se ejecutan las funcion de nuestra aplicación.
void main() {
    //Función para comenzar a correr la aplicación.
  runApp(const MyApp());
}

//En esta clase es donde se van a llamar las pantallas que forman nuestra aplicación. La estructura es algo similar a la de React.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
      home: CounterScreen(),
    );
  }
}

```

# Creación de la carpeta de "screen"

Es necesario mantener cierta estructura en la manera que se crean las pantallas, para que en un futuro cuando las necesitemos tengamos fácil acceso a ellas y los archivos de nuestra aplicación también tengan una estructura. 

Esta carpeta podría estar adentro de la carpeta de lib, no es nesario pero es una manera de acomodarse. 

# Creación del código de counter_screen.dart

En este archivo que vamos a crear dentro de la carpeta de screens es donde van a estar los elementos que conforman esta pantalla. También en este archivo vamos a programar la lógica que hará funcionar al contador. 

Primero tenemos que crear la clase de Widget que nos va a permitir utilizar estados, ya que cada vez que agreguemos una unidad al contador vamos a tener que "refrescar" la pantalla para que el cambio en la cantidad pueda ser visible. 

Para esto usaremos un StatefulWidget

```dart

//Clase para el Widget
class CounterScreen extends StatefulWidget {
    //Counter screen se hace una constante ya que no esta teniendo cambios en la composición de la pantalla y esto se hace con las ayudas de flutter, ya que nos va a marcar un error, pero los snippets nos ayudan con esto.
  const CounterScreen({Key? key}) : super(key: key);
    //Metodo que se tiene que sobreescribir para el funcionamiento de la clase StatefulWidget
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

```
Ahora se va a crear el código que nos permite poner los widgets que conforman la pantalla, la posición de ellos y la lógica del contador. 

```dart

//Clase para la estructura de la pantalla y la lógica del contador. 
class _CounterScreenState extends State<CounterScreen> {
  int counter = 10;

//Widget principal donde vamos a meter los demás elementos 
  @override
  Widget build(BuildContext context) {
      //Tamaño de la letra de todos los elementos internos
    const fontSize30 = TextStyle(fontSize: 30);

//Tipo contenedor para los demás elementos. En este caso es un contendero vertial.
    return Scaffold(
        //Titulo que va aparecer arriba de la aplicación.
      appBar: AppBar(
        title: const Text('CounterScreen'),
        elevation: 0,
      ),
      //Aqui centramos el body dentro del scaffold
      body: Center(
          //creamos a su widget hijo 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              'Número de Clicks',
              style: fontSize30,
            ),
            Text(
              '$counter',
              style: fontSize30,
            ),
          ],
        ),
      ),
      //floatingActionButtonLocation:FloatingActionButtonLocation.miniCenterDocked,
      //botón para agregar una unidad
      floatingActionButton: FloatingActionButton(
          //asiganación del ícono para el botón
        child: const Icon(Icons.add),
        //método onPressed para detectar que se hizo click en el botón
        onPressed: () {
            //se agrega el estado para que se pueda "refrescar" la pantalla 
          setState(() {
              //se agrega una unidad.
            counter++;
          });
        },
      ),
    );
  }
}

```

# Probar la aplicación de flutter.

Es necesario seleccionar el simulador que vamos a usar. Utilizando VS Code, tenemos que dar click en la pestaña de view, damos click en command palette y escribimos "Select Device" donde vamos a poder seleccionar el dispositivo donde queremos simular nuestra aplicación. 

Para correr la aplicación apretamos F5 y esto va a cargar el simulador y comenzar a correr la aplicación en el simulador. Esto puede tarmar un par de minutos. 
 
A01376766 Notas: 
1. Al final de la explicación del código estaría muy bien poner cómo debería verse cada archivo, es decir, todo el código que debe estar.
2. Poner un screenshot de la aplicación para comparar si se tiene el mismo resultado.
