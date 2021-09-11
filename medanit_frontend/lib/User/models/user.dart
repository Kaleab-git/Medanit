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
    required this.profile_pic_url,
    required this.password,
    required this.werified,
    required this.isAdmin,
    required this.bio,
  });

  final String id;
  final String name;
  final String username;
  final String email;
  final String profile_pic_url;
  final String password;
  final bool werified;
  final bool isAdmin;
  final String bio;

  @override
  List<Object> get props => [
        id,
        name,
        username,
        email,
        profile_pic_url,
        password,
        werified,
        isAdmin,
        bio
      ];

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        id: json['_id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        profile_pic_url: json['profile_pic_url'],
        password: json['password'],
        werified: json['werified'],
        isAdmin: json['isAdmin'],
        bio: json['bio']);
  }

  @override
  String toString() =>
      'Course { email: $email, title: $name, description: $username }';
}
