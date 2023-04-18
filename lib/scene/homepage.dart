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
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Study Buddy",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    FilledButton.tonalIcon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.comments),
                        label: Text("Chat"))
                  ],
                ),

                const Text(
                  "Group",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Upcoming Events",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(FontAwesomeIcons.house)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.usersRectangle)),
                    IconButton(
                        onPressed: () {}, icon: Icon(FontAwesomeIcons.gear))
                  ],
                )
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
