import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:labs_flutter_pulse/Models/groupe_model.dart';
import 'package:labs_flutter_pulse/Models/user_model.dart';
import 'package:labs_flutter_pulse/Models/vola_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:labs_flutter_pulse/Services/token_service.dart';

class MemberHttpService {
  var baseUrl = dotenv.env['HOST'];
  Future<List<Member>> fetchGroupe() async {
    final token = await TokenService().getToken();
    final response = await http.get(Uri.parse('${baseUrl}/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return List.generate(jsonResponse['hydra:member'].length, (index) {
        print(index);
        print(jsonResponse['hydra:member'][index]);
        return Member.fromJson(jsonResponse, jsonResponse['hydra:member'][index]);
      });
    } else {
      throw Exception('Unexpected error occured!');
    }

  }

  Future<Groupe> addVola(int montant, String description, String type, DateTime date) async {

    final token = await TokenService().getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}/api/volas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'montant': montant,
        'description': description,
        'type': type,
        'date': DateFormat('yyyy-MM-dd').format(date),
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var jsonResponse = jsonDecode(response.body);
      return Groupe.fromJson(jsonResponse, jsonResponse['hydra:member']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

}