import 'package:equatable/equatable.dart';
import 'package:medanit_frontend/Posts/post.dart';

class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostsLoadSuccess extends PostState {
  final List<Post> posts;

  PostsLoadSuccess([this.posts = const []]);

  @override
  List<Object> get props => [posts];
}

class PostCreateScuccess extends PostState {
  final Map message;

  PostCreateScuccess(this.message);

  @override
  List<Object> get props => [];
}

class PostFail extends PostState {}
