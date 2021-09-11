import 'package:medanit_frontend/Posts/models/models.dart';
import 'package:meta/meta.dart';
import 'package:medanit_frontend/User/user.dart';

class UserRepository {
  final UserDataProvider dataProvider;

  UserRepository({required this.dataProvider});

  Future<List<Post>> userPosts(String user_id) async {
    return await dataProvider.userPosts(user_id);
  }

  Future<User> usersInfo() async {
    return await dataProvider.usersInfo();
  }

  // Future<List<Post>> getPost(String postid) async {
  //   return await dataProvider.getPost(postid);
  // }

  Future<void> updateUser(User user) async {
    await dataProvider.updateUser(user);
  }

  Future<void> deletePost(String post_id) async {
    await dataProvider.deletePost(post_id);
  }
}
