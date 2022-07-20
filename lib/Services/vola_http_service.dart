import 'dart:convert';
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
}