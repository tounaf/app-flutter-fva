import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:labs_flutter_pulse/Models/user_model.dart';
import 'package:labs_flutter_pulse/Models/user_token.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:labs_flutter_pulse/Services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserHttpService {
  var baseUrl = dotenv.env['HOST'];
  Future<List<User>> findAll() async {
    final response = await http.get(Uri.parse('${baseUrl}/api/users'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return List.generate(jsonResponse['hydra:member'].length, (index) {
        return User.fromJson(jsonResponse, jsonResponse['hydra:member'][index]);
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<User> add(String username, String firstname, String lastname, String phone) async {
    final response = await http.post(
      Uri.parse('${baseUrl}/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse, jsonResponse['hydra:member']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> login(String username, String password) async {
    TokenService _prefs = TokenService();
    final response = await http.post(
      Uri.parse('${baseUrl}/api/login_check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var jsonResponse = jsonDecode(response.body);
      _prefs.setToken(jsonResponse['token'].toString());
      return Future.value(true);
    } else {
      throw Exception('Failed to create album.');
    }
  }

}