import 'package:flutter/material.dart';
import 'package:medanit_frontend/User/screens/profilePage.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/comments/screens/addCommentPage.dart';
import 'package:medanit_frontend/screens/SignUp.dart';
import 'package:medanit_frontend/screens/SignIn.dart';
import 'package:medanit_frontend/screens/addPostPage.dart';

class PostAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => SignInScreen());
    }

    if (settings.name == Feed.routeName) {
      return MaterialPageRoute(builder: (context) => Feed());
    }

    if (settings.name == PostDetail.routeName) {
      String postid = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => PostDetail(
                postid: postid,
              ));
    }

    if (settings.name == Doctor.routeName) {
      return MaterialPageRoute(builder: (context) => Doctor());
    }

    if (settings.name == SignUpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    }
    if (settings.name == addCommentPage.routeName) {
      final args = settings.arguments as CommentArgument;
      return MaterialPageRoute(
          builder: (context) => addCommentPage(
              prev_comment: args.prev_comment, post_id: args.post_id));
    }

    return MaterialPageRoute(builder: (context) => SignInScreen());
  }
}

class PostArgument {
  final Post post;
  final String postid;
  PostArgument({required this.post, required this.postid});
}

class CommentArgument {
  final String prev_comment;
  final String post_id;
  CommentArgument({required this.prev_comment, required this.post_id});
}
