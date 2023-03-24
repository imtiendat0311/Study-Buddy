import 'package:flutter/material.dart';
import 'package:study_buddy/component/input_text.dart';

final emailController = TextEditingController();
final passController = TextEditingController();
final secondPassController = TextEditingController();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(20),
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
                            onPressed: () {}, child: const Text("Register"))),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: FilledButton.tonal(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("/login");
                            },
                            child: Text("Login")))
                  ],
                ))));
  }
}
