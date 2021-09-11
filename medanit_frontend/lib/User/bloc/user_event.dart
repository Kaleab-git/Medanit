import 'package:equatable/equatable.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/User/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserInfoLoad extends UserEvent {
  final String user_id;

  const UserInfoLoad(this.user_id);

  @override
  List<Object> get props => [user_id];
}

// class UserPostLoad extends UserEvent {
//   final String user_id;

//   const UserPostLoad(this.user_id);

//   @override
//   List<Object> get props => [];
// }

// class LoadUserInfo extends UserEvent {
//   const LoadUserInfo();

//   @override
//   List<Object> get props => [];
// }

class UserUpdate extends UserEvent {
  final User user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Post Updated. Post: $user ';
}

class UserDelete extends UserEvent {
  const UserDelete();

  @override
  List<Object> get props => [];

  @override
  toString() => 'Post Deleted. Post:';
}

class UserPostDelete extends UserEvent {
  final Post post;
  final User user;

  const UserPostDelete(this.post, this.user);

  @override
  List<Object> get props => [];

  @override
  toString() => 'Post Deleted:';
}
