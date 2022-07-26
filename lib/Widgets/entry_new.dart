import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labs_flutter_pulse/Models/entry_model.dart';
import 'package:labs_flutter_pulse/Models/vola_model.dart';
import 'package:labs_flutter_pulse/Services/entry_http_service.dart';
import 'package:labs_flutter_pulse/Services/vola_http_service.dart';
import 'package:labs_flutter_pulse/Widgets/entry_list.dart';
import 'package:labs_flutter_pulse/Widgets/home.dart';
import 'package:labs_flutter_pulse/Widgets/vola_list.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// Define a custom Form widget.
class EntryForm extends StatefulWidget {
  final member;
  const EntryForm({super.key, required this.member});

  @override
  State<EntryForm> createState() => _EntryFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _EntryFormState extends State<EntryForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final EntryHttpService entryHttpService = EntryHttpService();
  final montantController = TextEditingController();
  final descriptionController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd H:m:s");
  // data post
  var montantVola;
  var descriptionVola;
  var typeVola = 'credit';
  var userId;
  DateTime _selectedDateVola =  DateTime.now();

  final _formKey = GlobalKey<FormState>();
  Future<Entries>? _futureVola;

  final List<Map<String, dynamic>> _types = [
    {
      'value': 'debit',
      'label': 'Debit',
      // 'icon': Icon(Icons.stop),
    },
    {
      'value': 'credit',
      'label': 'Credit',
      //'icon': Icon(Icons.fiber_manual_record),
      //'textStyle': TextStyle(color: Colors.red),
    }
  ];


  @override
  void initState() {
    super.initState();
    userId = widget.member['@id'];
    // Start listening to changes.
    montantController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    montantController.dispose();
    super.dispose();
  }

  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDateVola = pickedDate;
      });
    });
  }

  void _printLatestValue() {
  }

  Column buildColumn() {
      return Column(
        children: [
          ElevatedButton(child: Text(format.format(_selectedDateVola)), onPressed: _pickDateDialog),

          SelectFormField(
            type: SelectFormFieldType.dropdown, // or can be dialog
            initialValue: 'circle',
            icon: Icon(Icons.format_shapes),
            labelText: 'Type',
            items: _types,
            onChanged: (val) {
              setState(() {
                typeVola = val;
              });
            },
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ajouter un montant';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Montant'
            ),
            controller: montantController,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ajouter une description';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description'
            ),
            controller: descriptionController,
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

                entryHttpService.addEntry(
                    int.parse(montantController.text),
                    descriptionController.text,
                    typeVola,
                    _selectedDateVola,
                    userId
                ).then((value) {
                  print('-------value');
                  print(value);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EntryList()),
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
    String firstname = widget.member['firstname'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Paiment cotisation: $firstname'),
        backgroundColor: Colors.pink.shade400,
      ),
      body: Form(
        key: _formKey,
        child: buildColumn() //(_futureVola == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }
}