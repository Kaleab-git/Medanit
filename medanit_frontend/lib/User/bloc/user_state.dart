import 'package:equatable/equatable.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/User/models/models.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserPostsLoadSuccess extends UserState {
  final List<Post> posts;

  UserPostsLoadSuccess([this.posts = const []]);

  @override
  List<Object> get props => [posts];
}

class UserInfoLoadSuccess extends UserState {
  final User profile;

  UserInfoLoadSuccess(this.profile);
}

class UserAccountUpdateSuccess extends UserState {
  final User user;

  UserAccountUpdateSuccess(this.user);
}

class UserAccountdeleteSuccess extends UserState {
  UserAccountdeleteSuccess();
}

class UserFail extends UserState {}
