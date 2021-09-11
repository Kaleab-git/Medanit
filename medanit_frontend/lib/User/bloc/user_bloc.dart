// import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/User/user.dart';
import 'package:medanit_frontend/User/bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  // final x = postRepository.
  UserBloc({required this.userRepository}) : super(UserLoading());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserPostLoad) {
      yield UserLoading();
      try {
        final posts = await userRepository.userPosts(event.user_id);
        yield UserPostsLoadSuccess(posts);
      } catch (err) {
        print(err.toString());
        yield UserFail();
      }
    }

    // if (event is GetPost) {
    //   try {
    //     // final post = await postRepository.getPost(event.postid);
    //     final posts = await postRepository.getPosts();
    //     for (int i = 0; i < posts.length; i++) {
    //       if (posts[i].id == event.postid) {
    //         posts.add(posts[i]);
    //         break;
    //       }
    //     }
    //     yield PostsLoadSuccess(posts);
    //   } catch (err) {
    //     print(err.toString());
    //     yield PostFail();
    //   }
    // }

    if (event is LoadUserInfo) {
      try {
        final user = await userRepository.usersInfo();
        yield UserInfoLoadSuccess(user);
      } catch (_) {
        yield UserFail();
      }
    }

    if (event is UserUpdate) {
      try {
        await userRepository.updateUser(event.user);
        final user = await userRepository.usersInfo();
        yield UserAccountUpdateSuccess(user);
      } catch (error) {
        yield UserFail();
      }
    }

    if (event is UserDelete) {
      try {
        await userRepository.deletePost();
        yield UserAccountdeleteSuccess();
      } catch (_) {
        yield UserFail();
      }
    }
  }
}
