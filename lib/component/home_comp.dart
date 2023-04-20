import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_buddy/component/group_chat.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Group",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                StreamBuilder(
                  stream: db.collection("groups").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      var list = [];
                      for (var doc in snapshot.data!.docs) {
                        if (doc["members"].contains(auth.currentUser!.uid)) {
                          list.add([doc["title"], doc["course"], doc.id]);
                        }
                      }
                      if (list.isNotEmpty) {
                        return Container(
                            height: 60,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: 150,
                                        child: FilledButton.tonal(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GroupChat(
                                                          course: list[index]
                                                              [1],
                                                          title: list[index][0],
                                                          id: list[index][2],
                                                        ))),
                                            child: Text(list[index][0]))),
                                  );
                                }));
                      } else {
                        return Center(
                          child: Card(
                              shadowColor: Colors.black.withOpacity(0.5),
                              elevation: 2,
                              child: const SizedBox(
                                  height: 100,
                                  width: 400,
                                  child: Center(
                                    child: Text(
                                      "No Group",
                                      textAlign: TextAlign.center,
                                    ),
                                  ))),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const Text(
                  "Upcoming Events",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: db.collection("events").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!.docs.isEmpty) {
                            return Card(
                                shadowColor: Colors.black.withOpacity(0.5),
                                elevation: 2,
                                child: const SizedBox(
                                    height: 100,
                                    width: 400,
                                    child: Center(
                                      child: Text(
                                        "No Available Events",
                                        textAlign: TextAlign.center,
                                      ),
                                    )));
                          } else {
                            return Expanded(
                                child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: 150,
                                        child: FilledButton.tonal(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Column(
                                              children: [
                                                Text(snapshot.data!.docs[index]
                                                    ["title"]),
                                                Text(snapshot.data!.docs[index]
                                                    ["course"]),
                                                Text(snapshot.data!.docs[index]
                                                    ["date"]),
                                              ],
                                            ))));
                              },
                            ));
                          }
                        } else if (snapshot.hasError) {
                          return const Text("Error");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
              ],
            )));
  }
}
