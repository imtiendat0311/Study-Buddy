import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:study_buddy/component/search_result_page.dart';
import 'package:study_buddy/scene/create_group.dart';

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
                  StreamBuilder(
                      stream: db.collection("groups").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Card(
                                  shadowColor: Colors.black.withOpacity(0.5),
                                  elevation: 2,
                                  child: const SizedBox(
                                      height: 100,
                                      width: 400,
                                      child: Center(
                                        child: Text(
                                          "No event",
                                          textAlign: TextAlign.center,
                                        ),
                                      ))),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FilledButton.tonal(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        )),
                                        onPressed: () {},
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Text(snapshot.data!.docs[index]
                                                  ["title"]),
                                              Text(snapshot.data!.docs[index]
                                                  ["course"]),
                                              Text(snapshot.data!.docs[index]
                                                  ["location"]),
                                              Text(
                                                  "Member : ${snapshot.data!.docs[index]['members'].length}")
                                            ],
                                          ),
                                        )),
                                  );
                                });
                          }
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })
                ],
              ))),
    );
  }
}
