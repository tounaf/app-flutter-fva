import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Montant'
              ),
              controller: montantController,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description'
              ),
              controller: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}