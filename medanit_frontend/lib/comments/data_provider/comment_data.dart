import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:medanit_frontend/comments/models/comment.dart';
import 'package:http/http.dart' as http;
import '../../globals.dart' as globals;

class CommentDataProvider {
  final _baseUrl = 'http://localhost:3000/api/v1';
  final http.Client httpClient;
  final token = globals.storage.getItem('token');
  // final token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTNiYzM5ZmIxNjc2MmU1MDAzY2MwYzciLCJpc0FkbWluIjpmYWxzZSwiaWF0IjoxNjMxMzYyMDkyfQ.m4-mTHIeg9pMB4HIOZmTni3rintpHRQSBqeQ9gY88jk";
  CommentDataProvider({required this.httpClient});

  Future<Comments> createComment(String text, String post_id) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/posts/${post_id}/comments'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'content': text,
      }),
    );

    if (response.statusCode == 200) {
      return Comments.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Create Post Failed');
    }
  }

// $_baseUrl/api/posts
  Future<List<Comments>> getComments(String post_id) async {
    final response = await httpClient
        .get(Uri.parse('$_baseUrl/posts/${post_id}/comments'), headers: {
      "x-auth-token": token,
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      return posts.map((comment) => Comments.fromJson(comment)).toList();
    } else {
      throw Exception('Get comment Failed');
    }
  }

  Future<void> deleteComment(Comments comment) async {
    final http.Response response = await httpClient.delete(
      Uri.parse('$_baseUrl/posts/${comment.post_id}/comments/${comment.id}'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Delete Post Failed');
    }
  }

  Future<void> updateComment(Comments comment, String action) async {
    final http.Response response = await httpClient.put(
      Uri.parse(
          '$_baseUrl/posts/${comment.post_id}/comments/${comment.id}?action=${action}'),
      headers: <String, String>{
        "x-auth-token": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'content': comment.description,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Update Post Failed');
    }
  }
}
