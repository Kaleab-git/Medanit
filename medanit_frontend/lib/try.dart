// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(209, 117, 129, 1),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushNamed(context, Doctor.routeName);
//           },
//           icon: Icon(Icons.person),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: Icon(Icons.more_vert),
//           ),
//         ],
//       ),
//       body: BlocBuilder<PostBloc, PostState>(
//         builder: (_, state) {
//           if (state is PostFail) {
//             return Text('Error while performing operation');
//           }

//           if (state is PostsLoadSuccess) {
//             final posts = state.posts;

//             return ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (_, idx) => ListTile(
//                 subtitle: Container(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             child: Row(
//                               children: [
//                                 Icon(Icons.person, size: 50),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 10),
//                                   child: (Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Segni A',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                         TextSpan(
//                                           text: '@segniAdeba',
//                                           style: TextStyle(color: Colors.blue),
//                                         ),
//                                         TextSpan(
//                                             text: '  $bullet ',
//                                             style:
//                                                 TextStyle(color: Colors.black)),
//                                         TextSpan(
//                                             text: '${posts[idx].date}',
//                                             style: TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 13))
//                                       ])),
//                                     ],
//                                   )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                               padding: EdgeInsets.only(right: 15),
//                               child: Icon(Icons.bookmark_border))
//                         ],
//                       ),
//                       Padding(
//                           // '${posts[idx].title} \n ${posts[idx].description}'
//                           padding: EdgeInsets.only(
//                               left: 50, right: 50, bottom: 10, top: 10),
//                           child: RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 TextSpan(
//                                     text: '${posts[idx].title} \n',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () {
//                                         Navigator.of(context).pushNamed(
//                                             PostDetail.routeName,
//                                             arguments: posts[idx].id);
//                                       }),
//                                 TextSpan(
//                                     text: '${posts[idx].description}',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () {
//                                         Navigator.of(context).pushNamed(
//                                             PostDetail.routeName,
//                                             arguments: posts[idx].id);
//                                       }),
//                               ],
//                             ),
//                           )),
//                       Padding(
//                           padding: EdgeInsets.only(left: 50, right: 100),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         _PostUpdateHandler(
//                                             posts[idx], "upvote");
//                                       },
//                                       icon: Icon(upvote_icon),
//                                     ),
//                                     Text("${posts[idx].upvote}")
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         _PostUpdateHandler(
//                                             posts[idx], "downvote");
//                                       },
//                                       icon: Icon(downvote_icon),
//                                     ),
//                                     Text("${posts[idx].downvote}")
//                                   ],
//                                 ),
//                                 Row(children: [
//                                   IconButton(
//                                     onPressed: () => {print("Go to comments!")},
//                                     icon: Icon(Icons.comment_outlined),
//                                   ),
//                                   Text("${posts[idx].comments}")
//                                 ])
//                               ]))
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }

//           return CircularProgressIndicator();
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () => Navigator.of(context).pushNamed(
//       //     AddUpdateCourse.routeName,
//       //     arguments: CourseArgument(edit: false),
//       //   ),
//       //   child: Icon(Icons.add),
//       // ),
//     );
//   }
// }
