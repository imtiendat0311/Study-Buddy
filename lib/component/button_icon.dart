import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  const ButtonIcon({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: icon,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ));
  }
}
