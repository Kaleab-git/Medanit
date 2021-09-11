import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:medanit_frontend/User/user.dart';
import '../../globals.dart' as globals;

// final http.Client httpClient;
class AuthService {
  final _baseUrl = 'http://localhost:3000/api/v1';

  Dio dio = new Dio();
  // gets input parametrs from signin screen
  // returns whatever data it gets back to its caller if it succeeds. In this case a token
  // if request fails, there wont be content so != null can be used to figure out how the request ended

// "http://localhost:3000/api/v1/auth"
// GET user info
  Future<bool> SignIn(username, password) async {
    dynamic response = await http.post(
      Uri.parse('$_baseUrl/auth'),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: jsonEncode(
          <String, dynamic>{"username": username, "password": password}),
    );

    dynamic response_json = jsonDecode(response.body);

    if (response.statusCode == 400) {
      return false;
    }
    if (response.statusCode == 200) {
      //store token golablly
      globals.token = response_json['token'];
      //Get logged in user's data
      response = await http.get(Uri.parse('$_baseUrl/users/me'), headers: {
        "x-auth-token": globals.token,
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      });

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));
        globals.user = user;

        return true;
      } else {
        throw Exception('Get User Failed');
      }
    }
    return false;
  }

  Future<dynamic> SignUp(fullname, username, email, birthdate, password) async {
    dynamic response = await http.post(
      Uri.parse('$_baseUrl/users/'),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: jsonEncode(<String, dynamic>{
        "name": fullname,
        "username": username,
        "email": email,
        "birthdate": birthdate,
        "password": password
      }),
    );
    return jsonDecode(response.body);
  }
}
