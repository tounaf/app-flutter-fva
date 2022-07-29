import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Services/user_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/home.dart';
import 'package:http/http.dart' as http;


// Define a custom Form widget.
class UserLoginForm extends StatefulWidget {
  const UserLoginForm({super.key});

  @override
  State<UserLoginForm> createState() => _UserLoginFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _UserLoginFormState extends State<UserLoginForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final UserHttpService userHttpService = UserHttpService();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Future<bool> _isAuthenticated = Future.value(false);



  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    usernameController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  void _printLatestValue() {
    print('Second text field: ${usernameController.text}');
  }
  Column getColonne() {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 60.0),
            child: const Text(
              'Fva - Andranovelona',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        // Padding(
        //   padding: EdgeInsets.only(top: 60.0),
        //   child: Center(
        //     child: Container(
        //       width: 200,
        //       height: 100,
        //       child: Image.asset('assets/images/fav.png'),
        //     ),
        //   ),
        // ),

        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            validator: (value) {
              print(value);
              if (value == null || value.isEmpty) {
                return 'Ajouter login';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Login'
            ),
            controller: usernameController,
          ),
        ),
        Padding(padding: EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ajouter une description';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password'
              ),
              controller: passwordController,
            )),
        ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing login')),
              );
              _isAuthenticated = userHttpService.login(
                  usernameController.text,
                  passwordController.text
              );
              _isAuthenticated.then((value) {
                print(_isAuthenticated);
                if(value == true) {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                }
              });
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: getColonne() //(_futureVola == null) ? buildColumn() : buildFutureBuilder(),
        ),
      )
    );
  }
}