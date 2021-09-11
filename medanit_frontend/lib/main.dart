import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/bloc_observer.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/comments/comment.dart';
import 'package:medanit_frontend/User/user.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final PostRepository postRepository = PostRepository(
    dataProvider: PostDataProvider(
      httpClient: http.Client(),
    ),
  );

  final CommentRepository commentRepository = CommentRepository(
    dataProvider: CommentDataProvider(
      httpClient: http.Client(),
    ),
  );

  final UserRepository userRepository = UserRepository(
    dataProvider: UserDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(
    MedanitApp(
        postRepository: postRepository,
        commentRepository: commentRepository,
        userRepository: userRepository),
  );
}

class MedanitApp extends StatelessWidget {
  final PostRepository postRepository;
  final CommentRepository commentRepository;
  final UserRepository userRepository;

  MedanitApp(
      {required this.postRepository,
      required this.commentRepository,
      required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostRepository>(create: (context) => postRepository),
        RepositoryProvider<CommentRepository>(
            create: (context) => commentRepository),
        RepositoryProvider<UserRepository>(create: (context) => userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PostBloc(postRepository: this.postRepository)
                ..add(PostLoad())),
          BlocProvider(
              create: (context) =>
                  CommentsBloc(commentRepository: this.commentRepository)),
          BlocProvider(
              create: (context) => UserBloc(userRepository: userRepository))
        ],
        child: MaterialApp(
          title: 'Medanit App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: PostAppRoute.generateRoute,
        ),
      ),
    );
  }
}
