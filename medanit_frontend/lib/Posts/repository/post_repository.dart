import 'package:meta/meta.dart';
import 'package:medanit_frontend/Posts/post.dart';

class PostRepository {
  final PostDataProvider dataProvider;

  PostRepository({required this.dataProvider});

  Future<Post> createPost(Post post) async {
    return await dataProvider.createPost(post);
  }

  Future<List<Post>> getPosts() async {
    return await dataProvider.getPosts();
  }

  Future<void> updatePost(Post post) async {
    await dataProvider.updatePost(post);
  }

  Future<void> deletePost(String id) async {
    await dataProvider.deletePost(id);
  }
}
