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

  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTNiYzM5ZmIxNjc2MmU1MDAzY2MwYzciLCJpc0FkbWluIjpmYWxzZSwiaWF0IjoxNjMxMzYyMDkyfQ.m4-mTHIeg9pMB4HIOZmTni3rintpHRQSBqeQ9gY88jk";

  UserDataProvider({required this.httpClient});

// GET users posts
  Future<List<Post>> userPosts(String user_id) async {
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
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/users/me'), headers: {
      "x-auth-token": token,
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Get Post Failed');
    }
  }

  // Future<List<User>> getPost(String id) async {
  //   final response = await httpClient.get(Uri.parse('$_baseUrl/posts/$id'),
  //       headers: {"x-auth-token": token, "Access-Control-Allow-Origin": "*"});
  //   if (response.statusCode == 200) {
  //     final posts = [jsonDecode(response.body)];
  //     return posts.map((user) => User.fromJson(user)).toList();
  //   } else {
  //     throw Exception('Get Post Failed');
  //   }
  // }

// DELETE Account
  Future<void> deletePost() async {
    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/users/'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Delete Post Failed');
    }
  }

  // PUT Users account
  Future<void> updateUser(User user) async {
    final http.Response response = await httpClient.put(
      Uri.parse('$_baseUrl/users/me'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': user.name,
        'bio': user.bio,
        'username': user.username,
        'email': user.email,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Update Post Failed');
    }
  }
}
