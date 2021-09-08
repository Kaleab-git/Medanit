import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:medanit_frontend/Posts/models/post.dart';
import 'package:http/http.dart' as http;

class PostDataProvider {
  final _baseUrl = 'http://192.168.56.1:3000';
  final http.Client httpClient;

  PostDataProvider({required this.httpClient});

  Future<Post> createPost(Post course) async {
    final response = await httpClient.post(
      Uri.http('192.168.56.1:3000', '/courses'),
      headers: <String, String>{
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

  Future<List<Post>> getPosts() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/posts'));

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Get Post Failed');
    }
  }

  Future<void> deletePost(String id) async {
    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Delete Post Failed');
    }
  }

  Future<void> updatePost(Post post) async {
    final http.Response response = await httpClient.put(
      Uri.parse('$_baseUrl/posts/${post.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': post.id,
        'title': post.title,
        'side_effects': post.side_effects,
        'description': post.description,
        'upvote': post.upvote,
        'downvote': post.downvote,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Update Post Failed');
    }
  }
}
