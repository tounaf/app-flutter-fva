import 'package:http/http.dart' as http;
import 'package:labs_flutter_pulse/Models/user_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {

  Future<UserToken> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', token);
    return UserToken(token: token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt').toString();
  }

}

