import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/Posts/Screens/postPage.dart';
import 'package:medanit_frontend/Posts/Screens/profilePage.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/Posts/bloc/bloc.dart';

class Feed extends StatefulWidget {
  static const routeName = '/';

  @override
  _FeedState createState() => _FeedState();
}
class _FeedState extends State<Feed> {
  String username = "@segniAdeba";
  String upvote_count = "";
  String downvote_count = "";
  String description = "";
  String title = "";
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    IconData upvote_icon = Icons.thumb_up_outlined;
    IconData downvote_icon = Icons.thumb_down_outlined;
    // *** _PostUpdateHandler function
    void _PostUpdateHandler(Post post, [action]) {
      setState(() {
        if (action == "upvote") {
          upvote_icon = Icons.thumb_up_rounded;
          downvote_icon = Icons.thumb_down_outlined;
        } else if (action == "downvote") {
          upvote_icon = Icons.thumb_up_outlined;
          downvote_icon = Icons.thumb_down_rounded;
        } else {
          action == "";
        }
        // added Bloc for Post update
        context.read<PostBloc>().add(PostUpdate(post, action));
      });
    }
  