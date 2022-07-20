import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:labs_flutter_pulse/Modeles/vola_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class VolaHttpService {
  Future<List<Vola>> fetchVola() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/volas'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // print('=========');
      // print(jsonResponse);
      return List.generate(jsonResponse['hydra:member'].length, (index) {
        return Vola.fromJson(jsonResponse, jsonResponse['hydra:member'][index]);
      });
      // return jsonResponse.map((data) => Vola.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Vola> createAlbum(int montant, String description, String type, DateTime date) async {
    print('---- montant');
    print(montant);
    print('---- description');
    print(description);
    print('---- type');
    print(type);
    print('---- date');
    print(date);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/volas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'montant': montant,
        'description': description,
        'type': type,
        'date': DateFormat('yyyy-MM-dd').format(date),
      }),
    );
    print('------------ response new ---------');
    print(response);
    print(response.statusCode);
    print('------------ response new ---------');
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var jsonResponse = jsonDecode(response.body);
      return Vola.fromJson(jsonResponse, jsonResponse['hydra:member']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

}