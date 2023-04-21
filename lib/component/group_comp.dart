import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:study_buddy/component/search_result_page.dart';
import 'package:study_buddy/scene/create_group.dart';

import 'group_landing.dart';

class GroupComp extends StatefulWidget {
  const GroupComp({super.key});

  @override
  State<GroupComp> createState() => _GroupCompState();
}

class _GroupCompState extends State<GroupComp> {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateGroup())),
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Find Group",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton.tonal(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchResult())),
                        child: Row(
                          children: const [
                            Icon(FontAwesomeIcons.magnifyingGlass),
                            SizedBox(width: 20),
                            Text("Search")
                          ],
                        )),
                  ),
                  const Text(
                    "Available Groups",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          stream: db.collection("groups").snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              var list = [];
                              for (var doc in snapshot.data!.docs) {
                                if (!doc["members"]
                                    .contains(auth.currentUser!.uid)) {
                                  list.add([
                                    doc["title"],
                                    doc["course"],
                                    doc["location"],
                                    doc["members"],
                                    doc.id
                                  ]);
                                }
                              }
                              if (list.isEmpty) {
                                return Card(
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    elevation: 2,
                                    child: Container(
                                        height: 100,
                                        width: 400,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromRGBO(
                                                225, 214, 246, 0.5)),
                                        child: const Center(
                                          child: Text(
                                            "No Available Groups",
                                            textAlign: TextAlign.center,
                                          ),
                                        )));
                              } else {
                                return ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FilledButton.tonal(
                                            style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            )),
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GroupLanding(
                                                          title: list[index][0],
                                                          course: list[index]
                                                              [1],
                                                          location: list[index]
                                                              [2],
                                                          members: list[index]
                                                              [3],
                                                          id: list[index][4],
                                                        ))),
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  Text(list[index][0]),
                                                  Text(list[index][1]),
                                                  Text(list[index][2]),
                                                  Text(
                                                      "Member : ${list[index][3].length}")
                                                ],
                                              ),
                                            )),
                                      );
                                    });
                              }
                            } else if (snapshot.hasError) {
                              return const Text('Error');
                            } else {
                              return Center(
                                  child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child:
                                          const CircularProgressIndicator()));
                            }
                          }))
                ],
              ))),
    );
  }
}
