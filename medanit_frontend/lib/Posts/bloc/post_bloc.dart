import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/Posts/bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  // final x = postRepository.
  PostBloc({required this.postRepository}) : super(PostLoading());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostLoad) {
      yield PostLoading();
      try {
        final posts = await postRepository.getPosts();
        yield PostsLoadSuccess(posts);
      } catch (err) {
        print(err.toString());
        yield PostFail();
      }
    }

    if (event is GetPost) {
      try {
        // final post = await postRepository.getPost(event.postid);
        final posts = await postRepository.getPosts();
        for (int i = 0; i < posts.length; i++) {
          if (posts[i].id == event.postid) {
            posts.add(posts[i]);
            break;
          }
        }
        yield PostsLoadSuccess(posts);
      } catch (err) {
        print(err.toString());
        yield PostFail();
      }
    }

    if (event is PostCreate) {
      try {
        await postRepository.createPost(event.post);
        final posts = await postRepository.getPosts();
        yield PostsLoadSuccess(posts);
      } catch (_) {
        yield PostFail();
      }
    }

    if (event is PostUpdate) {
      try {
        await postRepository.updatePost(event.post, event.action);
        final posts = await postRepository.getPosts();
        yield PostsLoadSuccess(posts);
      } catch (error) {
        yield PostFail();
      }
    }

    if (event is PostDelete) {
      try {
        await postRepository.deletePost(event.post.id);
        final posts = await postRepository.getPosts();
        yield PostsLoadSuccess(posts);
      } catch (_) {
        yield PostFail();
      }
    }
  }
}
