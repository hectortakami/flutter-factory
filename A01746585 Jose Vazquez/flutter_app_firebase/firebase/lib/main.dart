import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Firestore Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Read Data from Cloud Firestore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
                height: 250,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: StreamBuilder<QuerySnapshot>(
                    stream: users,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading');
                      }

                      final data = snapshot.requireData;

                      return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return Text(
                              'My name is ${data.docs[index]['name']} and I am  ${data.docs[index]['age']}');
                        },
                      );
                    })),
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

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  var name = '';
  var age = 0;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What is your name?',
              labelText: 'Name',
            ),
            onChanged: (value) {
              name = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.date_range),
              hintText: 'What is your age?',
              labelText: 'Age',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) {
              age = int.parse(value);
            },
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleting Data from Cloud Firestore'),
                      ),
                    );

                    users
                        .doc('Usuarios')
                        .update({
                          'name': FieldValue.delete(),
                          'age': FieldValue.delete()
                        })
                        .then((value) => print('User Deleted'))
                        .catchError(
                            (error) => print('Failed to update user: $error'));
                  }
                },
                child: Text('Delete'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Updating Data from Cloud Firestore'),
                          ),
                        );

                        users
                            .doc('Usuarios')
                            .update({'name': name, 'age': age})
                            .then((value) => print('User updated'))
                            .catchError((error) =>
                                print('Failed to update user: $error'));
                      }
                    },
                    child: Text('Update'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Sending Data to Cloud Firestore'),
                              ),
                            );

                            users
                                .add({'name': name, 'age': age})
                                .then((value) => print('User added'))
                                .catchError((error) =>
                                    print('Failed to add user: $error'));
                          }
                        },
                        child: Text('Submit'),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
