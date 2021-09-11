import 'package:equatable/equatable.dart';
import 'package:medanit_frontend/comments/comment.dart';

class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsLoading extends CommentsState {}

class CommentsLoadSuccess extends CommentsState {
  final List<Comments> comments;

  CommentsLoadSuccess([this.comments = const []]);

  @override
  List<Object> get props => [comments];
}

class CommentsFail extends CommentsState {}
