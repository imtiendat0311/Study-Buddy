import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String text;
  final bool isHide;
  final TextEditingController controller;
  const InputText(
      {super.key,
      required this.isHide,
      required this.text,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5.0,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: isHide,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: text,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ));
  }
}
