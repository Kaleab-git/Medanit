import 'dart:convert';

import 'package:medanit_frontend/Posts/models/models.dart';
import 'package:meta/meta.dart';
import 'package:medanit_frontend/User/models/user.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class UserDataProvider {
  final _baseUrl = 'http://localhost:3000/api/v1';
  final http.Client httpClient;

  // final token = globals.storage.getItem('token');

  UserDataProvider({required this.httpClient});

// GET users posts
  Future<List<Post>> userPosts(String user_id) async {
    String token = globals.token;
    final response = await httpClient
        .get(Uri.parse('$_baseUrl/users/$user_id/posts'), headers: {
      "x-auth-token": token,
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      return posts.map((posts) => Post.fromJson(posts)).toList();
    } else {
      throw Exception('Create Post Failed');
    }
  }

// GET user info
  Future<User> usersInfo() async {
    String token = globals.token;
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/users/me'), headers: {
      "x-auth-token": token,
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception('Get User Failed');
    }
  }

// DELETE Account
  Future<void> deletePost(String post_id) async {
    String token = globals.token;

    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/posts/$post_id'),
      headers: {
        "x-auth-token": token,
      },
    );

    // if (response.statusCode != 204) {
    //   throw Exception('Delete Post Failed');
    // }
  }

  // PUT Users account
  Future<void> updateUser(User user) async {
    String token = globals.token;
    final http.Response response = await httpClient.put(
      Uri.parse('$_baseUrl/users/me'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': user.name,
        'username': user.username,
        'email': user.email,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Update Post Failed');
    }
  }
}
