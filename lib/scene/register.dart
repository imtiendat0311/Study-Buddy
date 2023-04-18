import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/component/input_text.dart';
import 'package:study_buddy/etc/check_stuff.dart';

var emailController;
var passController;
var secondPassController;
var firstNameController;
var lastNameController;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    secondPassController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    InputText(
                        isHide: false,
                        text: "Email",
                        controller: emailController),
                    InputText(
                        isHide: true,
                        text: "Password",
                        controller: passController),
                    InputText(
                        isHide: true,
                        text: "Validate Password",
                        controller: secondPassController),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: FilledButton(
                            onPressed: () async {
                              if (checkEmail(emailController.text) == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Invalid Email")));
                              } else if (checkPassword(passController.text,
                                      secondPassController.text) ==
                                  false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Invalid Password")));
                              } else if (passController.text !=
                                  secondPassController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Passwords do not match")));
                              } else {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passController.text)
                                    .then((value) => {
                                          value.user != null
                                              ? Navigator.of(context).pop()
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Invalid Email")))
                                        });
                              }
                            },
                            child: const Text("Register"))),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: FilledButton.tonal(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Login")))
                  ],
                ))));
  }
}
