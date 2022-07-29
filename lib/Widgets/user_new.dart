import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/entry_model.dart';
import 'package:labs_flutter_pulse/Models/groupe_model.dart';
import 'package:labs_flutter_pulse/Models/user_model.dart';
import 'package:labs_flutter_pulse/Models/vola_model.dart';
import 'package:labs_flutter_pulse/Services/entry_http_service.dart';
import 'package:labs_flutter_pulse/Services/groupe_http_service.dart';
import 'package:labs_flutter_pulse/Services/user_http_service.dart';
import 'package:labs_flutter_pulse/Services/vola_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/entry_list.dart';
import 'package:labs_flutter_pulse/Widgets/home.dart';
import 'package:labs_flutter_pulse/Widgets/user_list.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// Define a custom Form widget.
class UserNewForm extends StatefulWidget {
  const UserNewForm({super.key});

  @override
  State<UserNewForm> createState() => _UserNewFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _UserNewFormState extends State<UserNewForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final UserHttpService userHttpService = UserHttpService();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final GroupeHttpService groupeHttpService = GroupeHttpService();
  late Future <List<Groupe>> futureData;

  late String group;
  // data post

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureData = groupeHttpService.fetchGroupe();
    print('------ groupe');
    print(futureData);
    // Start listening to changes.
    // montantController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    // montantController.dispose();
    super.dispose();
  }


  void _printLatestValue() {
    // print('Second text field: ${montantController.text}');
  }

  Column buildColumn() {
      return Column(
        children: [
          FutureBuilder(
              future: futureData,
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) {
                print(snapshot);
                return DropdownButton<String>(

                    hint: Text("Select"),
                    value: '1',
                    onChanged: (newValue) {
                      setState(() {
                        group = newValue!;
                      });
                    },
                    items: snapshot.data!.map((gp) {
                      return DropdownMenuItem<String>(
                        child: Text(gp.name),
                        value: gp.id.toString(),
                      );
                    }).toList());
              }),
          TextFormField(
            validator: (value) {
              print(value);
              if (value == null || value.isEmpty) {
                return 'Ajouter Username';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nom d'utilisateur"
            ),
            controller: usernameController,
          ),
          TextFormField(
            validator: (value) {
              print(value);
              if (value == null || value.isEmpty) {
                return 'Ajouter nom';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nom'
            ),
            controller: firstnameController,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ajouter un prenom';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Prenom'
            ),
            controller: lastnameController,
          ),

          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ajouter un numero de telephone';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Contact'
            ),
            controller: phoneController,
          ),

          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ajouter un adresse';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adresse'
            ),
            controller: addressController,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

                // _isAuthenticated = entryHttpService.login(
                //     usernameController.text,
                //     passwordController.text
                // );
                // _isAuthenticated.then((value) {
                //   print(_isAuthenticated);
                //   if(value == true) {
                //     Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => const Home()),
                //     );
                //   }
                // });

                userHttpService.add(
                    usernameController.text,
                    firstnameController.text,
                    lastnameController.text,
                    phoneController.text,
                    addressController.text,
                    group
                ).then((value) {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserList()),
                  );
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
      appBar: AppBar(
        title: const Text('Nouveau'),
      ),
      body: Form(
        key: _formKey,
        child: buildColumn() //(_futureVola == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }
}