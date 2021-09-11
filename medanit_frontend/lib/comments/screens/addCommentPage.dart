import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medanit_frontend/Posts/widgets/buttonWidget.dart';
import 'package:medanit_frontend/comments/comment.dart';
import 'package:provider/provider.dart';
import 'package:medanit_frontend/comments/comment.dart';

class addCommentPage extends StatefulWidget {
  static const routeName = 'addComments';

  final String prev_comment;
  final String post_id;

  addCommentPage({required this.prev_comment, required this.post_id});

  @override
  _addCommentPageState createState() => _addCommentPageState();
}

class _addCommentPageState extends State<addCommentPage> {
  String text = "";
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // void _createPostHandler(String text, String post_id) {
    //   print("-------------------------------------------");
    //   print("$text, $post_id");
    //   context.read<CommentsBloc>().add(CommentsCreate(text, post_id));
    //   Navigator.popAndPushNamed(context, '/');
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 117, 129, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.local_pharmacy_sharp),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (_, state) {
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("@segnigodson")
                                ],
                              ))),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 8, bottom: 10),
                      child: Text('Add your comment',
                          style: TextStyle(fontSize: 15),
                          textAlign: (TextAlign.start)),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 10, right: 25),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length < 4) {
                              return 'Enter at least 4 characters';
                            } else {
                              return null;
                            }
                          },
                          maxLines: 5,
                          onSaved: (value) => setState(() {
                            text = value!;
                          }),
                        ),
                      ),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(
                      builder: (context) => ButtonWidget(
                        text: 'Comment',
                        onClicked: () {
                          final isValid = formKey.currentState!.validate();
                          // FocusScope.of(context).unfocus();

                          if (isValid) {
                            formKey.currentState!.save();

                            context
                                .read<CommentsBloc>()
                                .add(CommentsCreate(text, this.widget.post_id));
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
