import 'package:animations/animations.dart';
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
            const Text(
              "Member",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
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
                      label: "Create Group", onPressed: () {}, primary: false)),
              const SizedBox(
                height: 50,
              )
            ]))
          ]),
        )));
  }
}
