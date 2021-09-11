import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:medanit_frontend/Posts/post.dart';
import '../../globals.dart' as globals;

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final title_controller = TextEditingController();
  final description_controller = TextEditingController();
  final List<String> side_effects = [];
  String _error = "";

  void display_message(String message) async {
    // setState(() {
    _error = message;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(builder: (_, state) {
        if (state is PostCreateScuccess) {
          display_message(state.message['message']);
        }
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                showAlert(),
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
                                    '${globals.user.name}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '@${globals.user.username}',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              ))),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: title_controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7))),
                            ),
                          ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 10),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextField(
                              controller: description_controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              maxLines: 4,
                            ),
                          ))
                        ],
                      ),
                      Text(
                        'Side Effects',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects
                                          .contains("constipation")) {
                                        side_effects.remove('constipation');
                                      } else {
                                        side_effects.add('constipation');
                                      }
                                    },
                                  ),
                                ),
                                Text('Constipation',
                                    style: TextStyle(fontSize: 14))
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains(
                                          "skin rash or dermatitis")) {
                                        side_effects
                                            .remove('skin rash or dermatitis');
                                      } else {
                                        side_effects
                                            .add('skin rash or dermatitis');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Skin rash or Dermatitis',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains("nausea")) {
                                        side_effects.remove('nausea');
                                      } else {
                                        side_effects.add('nausea');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Nausea',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains("dizziness")) {
                                        side_effects.remove('dizziness');
                                      } else {
                                        side_effects.add('dizziness');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Dizziness',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains("drowsiness")) {
                                        side_effects.remove('drowsiness');
                                      } else {
                                        side_effects.add('drowsiness');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Drowsiness',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains("dry mouth")) {
                                        side_effects.remove('dry mouth');
                                      } else {
                                        side_effects.add('dry mouth');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Dry mouth',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains("headache")) {
                                        side_effects.remove('headache');
                                      } else {
                                        side_effects.add('headache');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Headache',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 8),
                                  child: RoundCheckBox(
                                    size: 25,
                                    onTap: (selected) {
                                      if (side_effects.contains("insomnia")) {
                                        side_effects.remove('insomnia');
                                      } else {
                                        side_effects.add('insomnia');
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'Insomnia',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, top: 10, right: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(209, 117, 129, 1)),
                              onPressed: () {
                                Map post = {
                                  "title": title_controller.text,
                                  "content": description_controller.text,
                                  "side_effects": side_effects
                                };
                                context.read<PostBloc>().add(PostCreate(post));
                              },
                              child: Text('Post'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget showAlert() {
    if (_error != "") {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline)),
            Expanded(
              child: Text(_error),
            ),
            // IconButton(
            //     onPressed: () {
            //       // setState(() {
            //       //   _error = "";
            //       // });
            //     },
            //     icon: Icon(Icons.close))
          ],
        ),
      );
    }
    return SizedBox(
      height: 55,
    );
  }
}
