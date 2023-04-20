import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/component/button_filled.dart';

import '../component/input_text.dart';
import '../component/map_comp.dart';
import '../component/map_page.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});
  @override
  State<CreateGroup> createState() => _CreateGroup();
}

class _CreateGroup extends State<CreateGroup> {
  var title = "Choose your location";
  var member = "Choose your member";
  var inputController = TextEditingController();
  var courseController = TextEditingController();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapPage()),
    );
    if (!mounted) return;
    if (result != null) {
      setState(() {
        title = result;
      });
    }
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Study Buddy',
                style: TextStyle(fontWeight: FontWeight.bold))),
        body: SafeArea(
            child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 50),
            const Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InputText(
                isHide: false,
                text: "Title",
                controller: inputController,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Course",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InputText(
                isHide: false,
                text: "Course",
                controller: courseController,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: MapComp(
                  title: title,
                  openContainer: () {
                    _navigateAndDisplaySelection(context);
                  },
                )),
            const SizedBox(height: 10),
            // const Text(
            //   "Member",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            // Padding(
            //     padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            //     child: OpenContainer(
            //       closedColor: Colors.white,
            //       closedShape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(15)),
            //       closedBuilder: (_, action) =>
            //           MapComp(title: member, openContainer: action),
            //       openBuilder: (_, action) => MapPage(),
            //       onClosed: (data) {
            //         member = data as String;
            //       },
            //     )),
            // SizedBox(
            //   height: 100,
            // ),
            Expanded(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                  height: 50,
                  width: 200,
                  child: ButtonFilled(
                      label: "Create Group",
                      onPressed: () {
                        if (inputController.text != "" &&
                            courseController.text != "" &&
                            title != "Choose your location") {
                          db.collection("groups").add({
                            "title": inputController.text,
                            "course": courseController.text,
                            "location": title,
                            "members": [auth.currentUser?.uid],
                            "searchParam": setSearchParam(inputController.text
                                .replaceAll(' ', '')
                                .toLowerCase()),
                          }).then((value) {
                            db
                                .collection("users")
                                .doc(auth.currentUser?.uid)
                                .set({
                              "groups": FieldValue.arrayUnion([value.id])
                            }, SetOptions(merge: true));
                            Navigator.pop(context);
                          });
                        }
                      },
                      primary: false)),
              const SizedBox(
                height: 50,
              )
            ]))
          ]),
        )));
  }
}


                            // var groupList = [];
                            // db
                            //     .collection("users")
                            //     .doc(auth.currentUser?.uid)
                            //     .get()
                            //     .then((ds) {
                            //   if (ds.data() != null) {
                            //     final data = ds.data() as Map<String, dynamic>;
                            //     groupList = data["groups"];
                            //   }
                            //   groupList.add(value.id);
                            //   if (ds.data() != null) {
                            //     db
                            //         .collection("users")
                            //         .doc(auth.currentUser?.uid)
                            //         .update({
                            //       "groups": groupList,
                            //     });
                            //   } else {
                            //     db
                            //         .collection("users")
                            //         .doc(auth.currentUser?.uid)
                            //         .set({
                            //       "groups": groupList,
                            //     });
                            //   }
                            // });