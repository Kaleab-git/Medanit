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
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Doctor.routeName);
          },
          icon: Icon(Icons.person),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
  body: BlocBuilder<PostBloc, PostState>(
        builder: (_, state) {
          if (state is PostFail) {
            return Text('Error while performing operation');
          }

          if (state is PostsLoadSuccess) {
            final posts = state.posts;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, idx) => ListTile(
                subtitle: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.person, size: 50),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: (Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Segni A',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      RichText(
                                          text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text: '@segniAdeba',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        TextSpan(
                                            text: '  $bullet ',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                            text: '${posts[idx].date}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13))
                                      ])),
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(Icons.bookmark_border))
                        ],
                      ),
                      Padding(
                          // '${posts[idx].title} \n ${posts[idx].description}'
                          padding: EdgeInsets.only(
                              left: 50, right: 50, bottom: 10, top: 10),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                // *** Added Navigator with Post data passed as an argument
                                TextSpan(
                                    text: '${posts[idx].title} \n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushNamed(
                                            PostDetail.routeName,
                                            arguments: posts[idx].id);
                                      }),
                                TextSpan(
                                    text: '${posts[idx].description}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushNamed(
                                            PostDetail.routeName,
                                            arguments: posts[idx].id);
                                      }),
                              ],
                            ),
                          )),