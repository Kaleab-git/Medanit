import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    // required this.profile_pic_url,
    required this.password,
    required this.verified,
    required this.isAdmin,
    required this.posts,
    required this.upvotes,
    required this.downvotes,
  });

  final String id;
  final String name;
  final String username;
  final String email;
  // final String profile_pic_url;
  final String password;
  final bool verified;
  final bool isAdmin;
  final int posts;
  final int upvotes;
  final int downvotes;

  @override
  List<Object> get props => [
        id,
        name,
        username,
        email,
        // profile_pic_url,
        password,
        verified,
        isAdmin,
        posts,
        upvotes,
        downvotes,
      ];

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        // profile_pic_url: json['profile_pic_url'],
        password: json['password'],
        verified: json['verified'],
        isAdmin: json['isAdmin'],
        posts: json['posts'],
        upvotes: json['upvotes'],
        downvotes: json['downvotes']);
  }

  @override
  String toString() =>
      'Course { email: $email, title: $name, description: $username }';
}
