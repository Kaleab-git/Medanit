import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/Posts/Screens/postPage.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/comments/comment.dart';
// import '../../Comment/comment.dart';

import 'package:medanit_frontend/comments/screens/addCommentPage.dart';

class PostDetail extends StatefulWidget {
  static const routeName = 'PostDetail';

  final String postid;

  PostDetail({required this.postid});

  @override
  _postDetailState createState() => _postDetailState();
}

class _postDetailState extends State<PostDetail> {
  // String username = "";
  String upvote_count = "";
  String downvote_count = "";
  String description = "";
  String title = "";
  String bullet = "\u2022 ";

  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    IconData upvote_icon = Icons.thumb_up_outlined;
    IconData downvote_icon = Icons.thumb_down_outlined;

    context.read<CommentsBloc>().add(CommentsLoad('${this.widget.postid}'));

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
        context.read<PostBloc>().add(PostUpdate(post, action));
        context.read<PostBloc>().add(GetPost(post.id));
      });
    }

    void _CommentUpdateHandler(Comments comment, [action]) {
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
        context.read<CommentsBloc>().add(CommentsUpdate(comment, action));
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(children: [
        BlocBuilder<PostBloc, PostState>(
          builder: (_, state) {
            if (state is PostFail) {
              return Text('Error while performing operation');
            }

            if (state is PostsLoadSuccess) {
              context.read<PostBloc>().add(GetPost(this.widget.postid));

              final Post post = state.posts[state.posts.length - 1];

              return Container(
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
                                          // this.widget.post.date}
                                          text: '${post.date}',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13))
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
                              TextSpan(
                                text: '${post.title} \n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '${post.description}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 50, right: 100),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _PostUpdateHandler(post, "upvote");
                                    },
                                    icon: Icon(upvote_icon),
                                  ),
                                  Text("${post.upvote}")
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _PostUpdateHandler(post, "downvote");
                                    },
                                    icon: Icon(downvote_icon),
                                  ),
                                  Text("${post.downvote}")
                                ],
                              ),
                              Row(children: [
                                IconButton(
                                  onPressed: () => {
                                    Navigator.of(context).pushNamed(
                                        addCommentPage.routeName,
                                        arguments: CommentArgument(
                                            prev_comment: "",
                                            post_id: '${post.id}'))
                                  },
                                  icon: Icon(Icons.comment_outlined),
                                ),
                                Text("${post.comments}")
                              ])
                            ])),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      indent: 40,
                      endIndent: 20,
                    ),
                  ],
                ),
              );
            }

            return CircularProgressIndicator();
          },
        ),
        BlocBuilder<CommentsBloc, CommentsState>(builder: (_, state) {
          if (state is CommentsLoadSuccess) {
            return Expanded(
                child: ListView.builder(
              itemCount: state.comments.length,
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
                                Icon(Icons.person, size: 25),
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
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
                                            text: '${state.comments[idx].date}',
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
                        ],
                      ),
                      Padding(
                          // '${posts[idx].title} \n ${posts[idx].description}'
                          padding: EdgeInsets.only(
                              left: 50, right: 50, bottom: 10, top: 10),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${state.comments[idx].description}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              // *** added PostHandler for actions upvote and downvote
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _CommentUpdateHandler(
                                        state.comments[idx], "upvote");
                                  },
                                  icon: Icon(upvote_icon),
                                ),
                                Text("${state.comments[idx].upvote}")
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _CommentUpdateHandler(
                                        state.comments[idx], "downvote");
                                  },
                                  icon: Icon(downvote_icon),
                                ),
                                Text("${state.comments[idx].downvote}")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          }
          return Text("Something might have gone wrong! Lets wait and see");
        }),
      ]),
    );
  }
}
