import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

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
  var inputController = TextEditingController();
  var courseController = TextEditingController();
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
            Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InputText(
                isHide: false,
                text: "Title",
                controller: inputController,
              ),
            ),
            Text(
              "Course",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: InputText(
                isHide: false,
                text: "Course",
                controller: courseController,
              ),
            ),
            Text(
              "Location",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            OpenContainer(
                closedBuilder: (_, action) => Text(title),
                // MapComp(title: title, openContainer: action),
                onClosed: (data) {
                  if (data != null) {
                    title = data as String;
                  }
                },
                openBuilder: (_, action) => MapPage(
                    onClosed: action as void Function({String returnValue}))),
            Text(
              "Member",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ]),
        )));
  }
}
