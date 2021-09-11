import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:medanit_frontend/Posts/models/post.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class PostDataProvider {
  final _baseUrl = 'http://localhost:3000/api/v1';
  final http.Client httpClient;
  // final token = globals.storage.getItem('token');
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTNiYzM5ZmIxNjc2MmU1MDAzY2MwYzciLCJpc0FkbWluIjpmYWxzZSwiaWF0IjoxNjMxMzYyMDkyfQ.m4-mTHIeg9pMB4HIOZmTni3rintpHRQSBqeQ9gY88jk";
  PostDataProvider({required this.httpClient});

  Future<Post> createPost(Post course) async {
    final response = await httpClient.post(
      Uri.http('192.168.56.1:3000', '/posts'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': course.title,
        'side_effects': course.side_effects,
        'description': course.description,
        'user_id': course.user_id,
      }),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Create Post Failed');
    }
  }

// $_baseUrl/api/posts
  Future<List<Post>> getPosts() async {
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/posts'), headers: {
      "x-auth-token": token,
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Get Post Failed');
    }
  }

// $_baseUrl/api/posts
  Future<List<Post>> getPost(String id) async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/posts/$id'),
        headers: {"x-auth-token": token, "Access-Control-Allow-Origin": "*"});
    if (response.statusCode == 200) {
      final posts = [jsonDecode(response.body)];
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Get Post Failed');
    }
  }

  Future<void> deletePost(String id) async {
    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Delete Post Failed');
    }
  }

  Future<void> updatePost(Post post, String? action) async {
    final http.Response response = await httpClient.put(
      Uri.parse('$_baseUrl/posts/${post.id}?action=$action'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(<String, dynamic>{
      //   'user_id': post.user_id,
      //   'title': post.title,
      //   'side_effects': post.side_effects,
      //   'content': post.description,
      // }),
    );

    if (response.statusCode != 204) {
      throw Exception('Update Post Failed');
    }
  }
}
