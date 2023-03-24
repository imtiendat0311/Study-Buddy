import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        FilledButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(FontAwesomeIcons.doorClosed),
            label: Text("log out"))
      ],
    ));
  }
}
