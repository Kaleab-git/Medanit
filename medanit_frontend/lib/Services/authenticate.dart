import 'package:dio/dio.dart';

class AuthService {
  Dio dio = new Dio();
  // gets input parametrs from signin screen
  // returns whatever data it gets back to its caller if it succeeds. In this case a token
  // if request fails, there wont be content so != null can be used to figure out how the request ended

  signin(name, password) async {
    try {
      return await dio.post(
        "http://localhost:3000/api/v1/auth",
        data: {"username": name, "password": password},
      );
    } on DioError catch (e) {
      print("Error while authenticating " + e.message);
    }
  }

  signup(name, username, email, password, birthdate) async {
    try {
      return await dio.post("http://localhost:3000/api/v1/users/", data: {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "birthdate": birthdate
      });
    } on DioError catch (e) {
      print("Error while registering " + e.message);
    }
  }
}
