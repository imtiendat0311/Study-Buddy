import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_buddy/component/group_chat.dart';

import 'group_comp.dart';

class GroupLanding extends StatelessWidget {
  final String id;
  final String title;
  final String location;
  final String course;
  final List members;
  const GroupLanding(
      {super.key,
      required this.id,
      required this.title,
      required this.location,
      required this.course,
      required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Members: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData && snapshots.data != null) {
                    if (snapshots.data!.docs.isEmpty) {
                      return const Text("No members");
                    } else {
                      var list = [];
                      for (var doc in snapshots.data!.docs) {
                        if (members.contains(doc.id)) {
                          list.add(doc["firstName"] + " " + doc["lastName"]);
                        }
                      }
                      return SizedBox(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: 150,
                                      child: Card(
                                          color:
                                              Color.fromRGBO(225, 214, 246, 1),
                                          child: Center(
                                            child: Text(
                                              list[index],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ))),
                                );
                              }));
                    }
                  } else if (snapshots.hasError) {
                    return const Text("Error");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            const Text(
              "Location: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Color.fromRGBO(225, 214, 246, 1),
                child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      location,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ))),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child: FilledButton.tonal(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("groups")
                              .doc(id)
                              .update({
                            "members": FieldValue.arrayUnion(
                                [FirebaseAuth.instance.currentUser!.uid])
                          });
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "groups": FieldValue.arrayUnion([id])
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupChat(
                                      course: course, title: title, id: id)));
                        },
                        child: const SizedBox(
                            height: 100,
                            width: 300,
                            child: Center(
                                child: Text(
                              "Join Group",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )))))
              ],
            ))
          ],
        ),
      )),
    );
  }
}
