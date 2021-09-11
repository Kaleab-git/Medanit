import 'dart:html';

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
    required this.comments,
    required this.date,
  });

  final String id;
  final String title;
  final List<dynamic> side_effects;
  final String description;
  final String user_id;
  final int upvote;
  final int downvote;
  final int comments;
  final String date;

  @override
  List<Object> get props => [
        id,
        title,
        side_effects,
        description,
        user_id,
        upvote,
        downvote,
        comments,
        date
      ];

  factory Post.fromJson(Map<dynamic, dynamic> json) {
    return Post(
        id: json['_id'],
        title: json['title'],
        side_effects: json['side_effects'],
        description: json['content'],
        user_id: json['user_id'],
        upvote: json['likes'],
        downvote: json['dislikes'],
        comments: json['comments'],
        date: json['date']);
  }

  @override
  String toString() =>
      'Course { id: $id, title: $title, description: $description }';
}
