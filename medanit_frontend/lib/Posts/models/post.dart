import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Post extends Equatable {
  Post({
    required this.id,
    required this.title,
    required this.side_effects,
    required this.description,
    required this.user_id,
    required this.upvote,
    required this.downvote,
  });

  final String id;
  final String title;
  final String side_effects;
  final String description;
  final int user_id;
  final int upvote;
  final int downvote;

  @override
  List<Object> get props =>
      [id, title, side_effects, description, user_id, upvote, downvote];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      side_effects: json['side_effects'],
      description: json['description'],
      user_id: json['user_id'],
      upvote: json['upvote'],
      downvote: json['downvote'],
    );
  }

  @override
  String toString() =>
      'Course { id: $id, title: $title, description: $description }';
}
