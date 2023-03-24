import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool isHide;
  final TextEditingController controller;
  const InputText({
    super.key,
    required this.isHide,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isHide,
      decoration: InputDecoration(
        labelText: text,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
