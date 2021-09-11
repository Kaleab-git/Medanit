import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/Posts/Screens/postPage.dart';
import 'package:medanit_frontend/Posts/post.dart';
import 'package:medanit_frontend/comments/comment.dart';
import 'package:flutter/gestures.dart';
import 'package:medanit_frontend/User/user.dart';
import '../../globals.dart' as globals;

class Doctor extends StatefulWidget {
  static const routeName = 'doctor';

  const Doctor({Key? key}) : super(key: key);

  @override
  DoctorState createState() => DoctorState();
}

class DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    String bullet = "\u2022 ";
    IconData upvote_icon = Icons.thumb_up_outlined;
    IconData downvote_icon = Icons.thumb_down_outlined;

    void _PostDeleteHandler(Post post, User user) {
      // setState(() {
      context.read<UserBloc>().add(UserPostDelete(post, user));
      // });
    }

    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (_, state) {
        if (state is UserInfoLoadSuccess) {
          print(
              "Yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeet state: ${state.posts.length}");
          return Container(
            child: Column(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.redAccent, Colors.pinkAccent])),
                    child: Container(
                      width: double.infinity,
                      height: 350.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              // backgroundImage: NetworkImage(
                              //   "assets/img/profile.png",
                              // ),
                              radius: 50.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "${state.user.name}",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 22.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Posts",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${state.user.posts}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Upvotes",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${state.user.upvotes}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Downvotes",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${state.user.downvotes}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.posts.length,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                    text: '@segniAdeba',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                  TextSpan(
                                                      text: '  $bullet ',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text:
                                                          '${state.posts[idx].date}',
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
                                    child: IconButton(
                                        onPressed: () {
                                          _PostDeleteHandler(
                                              state.posts[idx], state.user);
                                        },
                                        icon: Icon(Icons.delete_sharp)))
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
                                          text: '${state.posts[idx].title} \n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).pushNamed(
                                                  PostDetail.routeName,
                                                  arguments:
                                                      state.posts[idx].id);
                                            }),
                                      TextSpan(
                                          text:
                                              '${state.posts[idx].description}',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).pushNamed(
                                                  PostDetail.routeName,
                                                  arguments:
                                                      state.posts[idx].id);
                                            }),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 50, right: 100),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    // *** added PostHandler for actions upvote and downvote
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(upvote_icon),
                                      ),
                                      Text("${state.posts[idx].upvote}")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(downvote_icon),
                                      ),
                                      Text("${state.posts[idx].downvote}")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is UserLoading) {
          print(
              "-----------------------I shouuuuld not have gotten executed-----------------------");
          context.read<UserBloc>().add(UserInfoLoad("${globals.user.id}"));
        }
        return Text("$state");
      }),
    );
  }
}
