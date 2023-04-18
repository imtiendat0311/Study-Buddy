import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_buddy/component/search_bar.dart';
import 'package:study_buddy/component/search_page.dart';
import 'package:study_buddy/component/search_result_page.dart';
import 'package:study_buddy/scene/create_group.dart';

class GroupComp extends StatefulWidget {
  const GroupComp({super.key});

  @override
  State<GroupComp> createState() => _GroupCompState();
}

class _GroupCompState extends State<GroupComp> {
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
                  FilledButton.tonal(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult())),
                      child: Text("Search")),
                  const Text(
                    "Available Groups",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ))),
    );
  }
}
