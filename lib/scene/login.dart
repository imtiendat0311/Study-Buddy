import 'package:flutter/material.dart';
import '../component/input_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final emailController = TextEditingController();
final passController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  void _printLatestValue() {
    print('email: ${emailController.text} pass: ${passController.text}');
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    emailController.addListener(_printLatestValue);
    passController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        InputText(
          isHide: false,
          text: "Email",
          controller: emailController,
        ),
        const SizedBox(
          height: 40,
        ),
        InputText(
          isHide: true,
          text: "Password",
          controller: passController,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 100,
          child: FilledButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text,
                      )
                      .then((value) =>
                          Navigator.of(context).pushReplacementNamed('/'));
                } on FirebaseAuthException catch (e) {}
              },
              child: const Text("Login")),
        ),
        SizedBox(
            width: 100,
            child: FilledButton.tonal(
                onPressed: () {}, child: const Text("Register"))),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FilledButton.tonal(
              onPressed: () {},
              child: const Icon(FontAwesomeIcons.google),
            ),
            FilledButton.tonal(
                onPressed: () {}, child: const Icon(FontAwesomeIcons.facebook)),
            FilledButton.tonal(
                onPressed: () {}, child: const Icon(FontAwesomeIcons.twitter))
          ],
        )
      ]),
    )));
  }
}
