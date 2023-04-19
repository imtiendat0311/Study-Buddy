import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                          list.add([doc["title"], doc["course"]]);
                        }
                      }
                      if (list.length > 0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(list[index][0]),
                                subtitle: Text(list[index][1]),
                              );
                            });
                      } else {
                        return const Text("No groups");
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

                // FilledButton.icon(
                //     onPressed: () async {
                //       await FirebaseAuth.instance.signOut();
                //     },
                //     icon: Icon(FontAwesomeIcons.doorClosed),
                //     label: Text("log out"))
              ],
            )));
  }
}
