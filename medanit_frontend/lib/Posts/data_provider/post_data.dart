import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:medanit_frontend/Posts/models/post.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class PostDataProvider {
  final _baseUrl = 'http://localhost:3000/api/v1';
  final http.Client httpClient;
  // final token = globals.storage.getItem('token');

  PostDataProvider({required this.httpClient});

  Future<Map> createPost(Map post) async {
    String token = globals.token;
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/posts'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': post["title"].toString(),
        'side_effects': post["side_effects"],
        'content': post["content"].toString(),
      }),
    );
    try {
      return jsonDecode(response.body);
    } catch (_) {
      throw Exception('Create Post Failed');
    }
  }

// $_baseUrl/api/posts
  Future<List<Post>> getPosts() async {
    String token = globals.token;

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
    String token = globals.token;

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
    String token = globals.token;

    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: {
        "x-auth-token": token,
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Delete Post Failed');
    }
  }

  Future<void> updatePost(Post post, String? action) async {
    String token = globals.token;

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
