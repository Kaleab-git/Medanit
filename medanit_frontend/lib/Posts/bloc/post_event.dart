import 'package:equatable/equatable.dart';
import 'package:medanit_frontend/Posts/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostLoad extends PostEvent {
  const PostLoad();

  @override
  List<Object> get props => [];
}

class GetPost extends PostEvent {
  final String postid;

  const GetPost(this.postid);
  @override
  List<Object> get props => [];
}

class PostCreate extends PostEvent {
  final Post post;

  const PostCreate(this.post);

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'Post Created. Post: $post';
}

class PostUpdate extends PostEvent {
  final Post post;
  final String? action;

  const PostUpdate(this.post, [this.action]);

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'Post Updated. Post: $post action $action';
}

class PostDelete extends PostEvent {
  final Post post;

  const PostDelete(this.post);

  @override
  List<Object> get props => [post];

  @override
  toString() => 'Course Deleted. Post: $post';
}
