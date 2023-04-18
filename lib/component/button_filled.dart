import 'package:flutter/material.dart';

class ButtonFilled extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool primary;
  const ButtonFilled(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.primary});

  @override
  Widget build(BuildContext context) {
    if (primary) {
      return SizedBox(
          height: 60,
          width: double.infinity,
          child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(label,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18))));
    } else {
      return SizedBox(
          height: 60,
          width: double.infinity,
          child: FilledButton.tonal(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(label,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18))));
    }
  }
}
