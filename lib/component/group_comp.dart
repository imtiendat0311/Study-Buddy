import 'package:flutter/material.dart';

class GroupComp extends StatefulWidget {
  const GroupComp({super.key});

  @override
  State<GroupComp> createState() => _GroupCompState();
}

class _GroupCompState extends State<GroupComp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("GroupComp"));
  }
}
