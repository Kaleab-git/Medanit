import 'package:meta/meta.dart';
import 'package:medanit_frontend/comments/comment.dart';

class CommentRepository {
  final CommentDataProvider dataProvider;

  CommentRepository({required this.dataProvider});

  Future<Comments> createComment(String text, String post_id) async {
    return await dataProvider.createComment(text, post_id);
  }

  Future<List<Comments>> getComments(String post_id) async {
    return await dataProvider.getComments(post_id);
  }

  Future<void> updateComment(Comments comment, String action) async {
    await dataProvider.updateComment(comment, action);
  }

  Future<void> deletePost(Comments comment) async {
    await dataProvider.deleteComment(comment);
  }
}
