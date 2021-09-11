// import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/comments/comment.dart';
import 'package:medanit_frontend/comments/bloc/bloc.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentRepository commentRepository;
  // final x = postRepository.
  CommentsBloc({required this.commentRepository}) : super(CommentsLoading());

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is CommentsLoad) {
      yield CommentsLoading();
      try {
        final posts = await commentRepository.getComments(event.post_id);
        yield CommentsLoadSuccess(posts);
      } catch (err) {
        print(err.toString());
        yield CommentsFail();
      }
    }

    if (event is CommentsCreate) {
      try {
        await commentRepository.createComment(event.text, event.post_id);
        final comments = await commentRepository.getComments(event.post_id);
        yield CommentsLoadSuccess(comments);
      } catch (_) {
        yield CommentsFail();
      }
    }

    if (event is CommentsUpdate) {
      try {
        await commentRepository.updateComment(event.comment, event.action);
        final comments =
            await commentRepository.getComments(event.comment.post_id);
        yield CommentsLoadSuccess(comments);
      } catch (error) {
        yield CommentsFail();
      }
    }

    if (event is CommentsDelete) {
      try {
        await commentRepository.deletePost(event.comment);
        final comments = await commentRepository.getComments(event.post_id);
        yield CommentsLoadSuccess(comments);
      } catch (_) {
        yield CommentsFail();
      }
    }
  }
}
