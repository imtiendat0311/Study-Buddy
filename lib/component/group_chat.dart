import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';

var _controller;

class GroupChat extends StatefulWidget {
  final String course;
  final String id;
  final String title;

  const GroupChat(
      {super.key, required this.title, required this.course, required this.id});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .doc(widget.id)
                  .collection("mess")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        var flag = false;
                        if (doc["sender"] ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          flag = true;
                        }
                        var nameUser = "";
                        if (!flag) {
                          return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(doc["sender"])
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  nameUser = snapshot.data!["firstName"] +
                                      " " +
                                      snapshot.data!["lastName"];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                doc["content"],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: Text(nameUser,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text("Error");
                                } else {
                                  return const Text("Loading");
                                }
                              });
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(225, 214, 246, 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      doc["content"],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return Container();
                }
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          hintText: "Type a message..."),
                    ),
                  ),
                  FilledButton.tonalIcon(
                      onPressed: () {
                        // mess => group id => date =>
                        final date = DateTime.now();
                        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                        FirebaseFirestore.instance
                            .collection("messages/${widget.id}/mess")
                            .doc()
                            .set({
                          "content": _controller.text,
                          "sender": FirebaseAuth.instance.currentUser!.uid,
                          "timestamp": date,
                        }).then((value) => _controller.clear());
                      },
                      icon: const Icon(FontAwesomeIcons.paperPlane),
                      label: const Text("Send")),
                ],
              ),
            )
          ]),
        ));
  }
}
