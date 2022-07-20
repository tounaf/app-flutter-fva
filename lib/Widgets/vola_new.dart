import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


Future<Vol> createAlbum(String montant, String description) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/user/list'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'montant': montant,
      'description': description,
    }),
  );
  print('response  =======');
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Vol.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}


class Vol {
  final int id;
  final String montant;
  final String description;

  const Vol({required this.id, required this.montant, required this.description});

  factory Vol.fromJson(Map<String, dynamic> json) {
    return Vol(
      id: json['id'],
      montant: json['montant'],
      description: json['description'],
    );
  }
}
// Define a custom Form widget.
class VolaForm extends StatefulWidget {
  const VolaForm({super.key});

  @override
  State<VolaForm> createState() => _VolaFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _VolaFormState extends State<VolaForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final montantController = TextEditingController();
  final descriptionController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  DateTime _selectedDate =  DateTime.now();
  final _formKey = GlobalKey<FormState>();
  Future<Vol>? _futureVola;

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
        _selectedDate = pickedDate;
      });
    });
  }

  void _printLatestValue() {
    print('Second text field: ${montantController.text}');
  }

  FutureBuilder<Vol> buildFutureBuilder() {
    return FutureBuilder<Vol>(
      future: _futureVola,
      builder: (context, snapshot) {
        print('====== data =========');
        print(snapshot.data);
        print('====== data =========');
        if (snapshot.hasData) {
          return Text(snapshot.data!.montant + " " +snapshot.data!.description);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
  Column buildColumn() {
      return Column(
        children: [
          ElevatedButton(child: Text('Add Date' + format.format(_selectedDate)), onPressed: _pickDateDialog),

          SelectFormField(
            type: SelectFormFieldType.dropdown, // or can be dialog
            initialValue: 'circle',
            icon: Icon(Icons.format_shapes),
            labelText: 'Shape',
            items: _types,
            onChanged: (val) => print(val),
            onSaved: (val) => print(val),
          ),
          TextFormField(
            validator: (value) {
              print(value);
              if (value == null || value.isEmpty) {
                return 'Ajouter un montant';
              }
              return null;
            },
            decoration: InputDecoration(
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
            decoration: InputDecoration(
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
                setState(() {
                  _futureVola = createAlbum(montantController.text, descriptionController.text);
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
        child: (_futureVola == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }
}