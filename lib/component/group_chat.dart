import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GroupChat extends StatefulWidget {
  final String course;

  final String title;

  const GroupChat({super.key, required this.title, required this.course});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Column(children: [Text("Group Chat"), Text("Group Message")]),
        ));
  }
}
