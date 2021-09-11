import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Comments extends Equatable {
  Comments({
    required this.id,
    required this.description,
    required this.user_id,
    required this.post_id,
    required this.upvote,
    required this.downvote,
    required this.date,
  });

  final String id;
  final String description;
  final String user_id;
  final String post_id;
  final int upvote;
  final int downvote;
  final String date;

  @override
  List<Object> get props =>
      [id, description, user_id, post_id, upvote, downvote, date];

  factory Comments.fromJson(Map<dynamic, dynamic> json) {
    return Comments(
        id: json['_id'],
        description: json['content'],
        user_id: json['user_id'],
        post_id: json['post_id'],
        upvote: json['likes'],
        downvote: json['dislikes'],
        date: json['date']);
  }

  @override
  String toString() => 'Course { id: $id, description: $description }';
}
