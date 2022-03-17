# Documentación de Firebase

El objetivo de este proyecto es aprender como es el proceso de conexión entre una aplicación de Flutter y Firebase. La intensión es poder realizar crear registro, actualizarlos, leerlos y poder borrarlos.

La aplicación que realizamos simplemente realiza estas acciones, la de delete todavía esta pendiente, pero el aspecto estético no era parte del objetivo para el miércoles 16 de marzo de 2022. 

# Requesitos para Firebase. 

Realmente no hay ningún requisito de Firebase, solo es necesario tener una cuenta de Google con créditos para poder hacer uso de este servicio. En caso de no contar con créditos en la cuenta, se puede agregar una tarjeta de crédito o se puede crear una cuenta nueva donde tendrás 300 dólares de créditos de Google para hacer pruebas y utilizar diferentes servicios de Google Cloud. 

# Código de dart para la aplicación de Flutter

Lo primero que tenemos que hacer es una aplicación sencilla, en donde vamos a tener diferentes widgets donde vamos a desplegar información, widget de Forms para tomar los datos que queremos subir a Firebase y un botón para ejecutar esta acción. 

main.dart

```dart

//paquetes a importar
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//Main que se convierte en una función asincrona para poder cargar los datos de firebase una vez que se inicia la aplicación 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//Clase para llamar las pantallas que se van a crear, como solo tenemos un Home Screen solo se llama esa pantalla.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

//Clase HomeScreen donde vamos a tener los widgets 
class HomeScreen extends StatelessWidget {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
      //Scaffold para acomodar los widgets que vamos a utilizar de manera vertical
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Firestore Demo'),
      ),
      //Padding para acomodar el Scaffold en el centro de la pantalla 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Read Data from Cloud Firestore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            //Container donde vamos a desplegar los datos de Firebase
            Container(
                height: 250,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: StreamBuilder<QuerySnapshot>(
                    stream: users,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                        //Este if es para mostrar un mensaje de error en caso de que no se haya podido descargar la información de Firebase de manera correcta.
                      if (snapshot.hasError) {
                        return Text('Something went worng');
                      }
                      //Este if es para mostrar el mensaje de loading mientras se carga la información de Firebase 
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading');
                      }

                      final data = snapshot.requireData;
                        //En este ListView es donde vamos a mostrar la lista de los datos de Firebase
                      return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                            //Se acomodan los datos junto con el texto que se va a desplegar ¿.
                          return Text(
                              'My name is ${data.docs[index]['name']} and I am  ${data.docs[index]['age']}');
                        },
                      );
                    })),
            //Wigdet unicamente utilizado para desplegar un mensaje
            Text(
              'Write Data from Cloud Firestore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            MyCustomForm()
          ],
        ),
      ),
    );
  }
}

//Clase que se va a crear para poder utilizar un formulario en el cual vamos a recibir los datos introducidos por el usuario. Cuenta con estados ya que una vez que se introduce los campos necesarios se tiene que hacer un update para poder agregar los datos a Firebase.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

//Formulario 
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  //Datos del formulario que vamos a recibir.
  var name = '';
  var age = 0;
  
  //Widget en el cual vamos a crear el formulario
  @override
  Widget build(BuildContext context) {
    //Referencia a la tabla de datos de Firebase que vamos a estar utilizando apra este ejemplo.
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    //Formulario
    return Form(
      key: _formKey,
      //Columna para la organización del formulario.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Campo de texto donde el usuario va a introducir el nombre, cuenta con um hint y un label para el campo de texto.
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What is your name?',
              labelText: 'Name',
            ),
            //Método donde se cambia el estado para poder hacer un update y subir los datos a Firebase.
            onChanged: (value) {
              name = value;
            },
            //Método para validar que se introdujeron datos de manera correcta.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          //Campo de texto donde el usuario va a introducir el nombre, cuenta con um hint y un label para el campo de texto.
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.date_range),
              hintText: 'What is your age?',
              labelText: 'Age',
            ),
            //Método donde se cambia el estado para poder hacer un update y subir los datos a Firebase. En este método se hace un parse ya que a Firebase vamos a estar subiendo un int.
            onChanged: (value) {
              age = int.parse(value);
            },
            //Método para validar que se introdujeron datos de manera correcta.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          //Creación del botón donde se va a ejecutar la acción de hacer update o crear los datos de Firebase.
          Center(
            child: ElevatedButton(
              //Se ejecuta una SnackBar para dar la señal al usuario de que se esta enviando la información.
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sending Data to Cloud Firestore'),
                    ),
                  );
                //Método donde se está agregando la infomración a Firebase.
                  users
                      .add({'name': name, 'age': age})
                      .then((value) => print('User added'))
                      .catchError(
                          (error) => print('Failed to add user: $error'));
                }
              },
              //Texto de submit.
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
```

# Creación de la base de datos en Firebase y configuración dentro de Flutter.

## Instrucciones: 

1. Primero se tiene que crear el proyecto en Firebase entrando al link: https://firebase.google.com/

2. Una vez que se entra a Firebase se tendrá la opción de dar click en un botón de "Agregar proyecto" para crear un proyecto nuevo de Firebase. 

3. Se asigna un nombre al proyecto. 

4. Se da click en siguiente y puedes elegir si usar Google Analytics. 

5. Una vez creado el proyecto la página de Firebase te va a llevar a la pantalla del proyecto, donde podras ver las instrucciones a seguir para utilizar servicios de Google en Android, iOS o para Web. Solo tienes que dar click en la opción que deseas utilizar y seguir los pasos de los pedazos de código que se tienen que copiar y donde pegarlos. 

Nota: En nuesto caso en específico fue necesario agregar ciertas líneas de código debído a un problema de compatibilidad entre el SDK mínimo de Firebase que es compatible con el SDK de Flutter. 

En el archivo de build.gradle dentro de la carpeta de "app" dentro de la carpeta de "android" dentro del proyecto fue neceserio meter las siguientes lineas. 

Dentro de "dependencies":

implementation 'com.android.support:multidex:1.0.3'

Dentro de "defaultConfig":

Especificar una version mínima del SDK que se va a utilizar de Flutter

minSdkVersion 19

Y hacer enable de multidex

multiDexEnabled true

## Creación de la base de datos

1. Dentro de Firebase se selecciona la opción del menú de la izquierda "Crear una nueva base de datos"

2. Se inicia la base de datos en test mode y se selecciona una ubicación de la base de datos dentro de los servidores de google. 

3. Dentro de Firestore, se crea una nueva colección, que va a ser nuestra base de datos.

4. Se asigna un nombre a la colección 

5. Se agregan los campos que se van a recibir, del tipo que van a ser y se puede agregar un valor a los campos. Esto va a crear los documentos con un ID para cada documento que se va a ir agregrando a Firestore, desde la interfaz a mano o desde la aplicación que utilice este servicio. 


# Resultados

La aplicación debería ser capáz de agregar datos a Firestore y poder leer datos de ella. 


## Interfaz

Screenshots del resultado final de la interfaz. 
