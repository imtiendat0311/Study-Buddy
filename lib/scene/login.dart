import 'package:flutter/material.dart';
import 'package:study_buddy/etc/check_stuff.dart';
import 'package:study_buddy/scene/register.dart';
import '../component/button_filled.dart';
import '../component/button_icon.dart';
import '../component/input_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

var emailController;
var passController;

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  // void _printLatestValue() {
  //   print('email: ${emailController.text} pass: ${passController.text}');
  // }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    // Start listening to changes.
    // emailController.addListener(_printLatestValue);
    // passController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void doLogin() async {
    if (checkEmail(emailController.text) &&
        checkPassword(passController.text, passController.text)) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .catchError((error) {
        if (error.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No user found for that email.')));
        } else if (error.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wrong password provided for that user.')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        InputText(
          isHide: false,
          text: "Email",
          controller: emailController,
        ),
        const SizedBox(
          height: 20,
        ),
        InputText(
          isHide: true,
          text: "Password",
          controller: passController,
        ),
        const SizedBox(
          height: 40,
        ),
        ButtonFilled(primary: true, onPressed: doLogin, label: "Login"),
        const SizedBox(
          height: 20,
        ),
        ButtonFilled(
          primary: false,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Register(),
              )),
          label: "Register",
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Or login with",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonIcon(
              icon: Icon(FontAwesomeIcons.google),
              onPressed: () {},
            ),
            ButtonIcon(
              icon: Icon(FontAwesomeIcons.facebook),
              onPressed: () {},
            ),
            ButtonIcon(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () {},
            )
          ],
        )
      ]),
    )));
  }
}
