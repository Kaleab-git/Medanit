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

  Future<List<Post>> getPost(String postid) async {
    return await dataProvider.getPost(postid);
  }

  Future<void> updatePost(Post post, String? action) async {
    await dataProvider.updatePost(post, action);
  }

  Future<void> deletePost(String id) async {
    await dataProvider.deletePost(id);
  }
}
