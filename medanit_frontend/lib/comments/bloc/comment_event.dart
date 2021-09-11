import 'package:equatable/equatable.dart';
import 'package:medanit_frontend/comments/comment.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class CommentsLoad extends CommentsEvent {
  final String post_id;

  const CommentsLoad(this.post_id);

  @override
  List<Object> get props => [];
}

class CommentsCreate extends CommentsEvent {
  final String text;
  final String post_id;

  const CommentsCreate(this.text, this.post_id);

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'Comment Created. Post: $text';
}

class CommentsUpdate extends CommentsEvent {
  final Comments comment;
  final String action;

  const CommentsUpdate(this.comment, this.action);

  @override
  List<Object> get props => [comment];

  @override
  String toString() => 'Post Updated. Post: $comment action $action';
}

class CommentsDelete extends CommentsEvent {
  final Comments comment;
  final String post_id;

  const CommentsDelete(this.comment, this.post_id);

  @override
  List<Object> get props => [comment];

  @override
  toString() => 'Course Deleted. Post: $comment';
}
