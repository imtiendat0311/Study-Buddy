import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MapComp extends StatelessWidget {
  final String title;
  final VoidCallback openContainer;

  const MapComp({super.key, required this.title, required this.openContainer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: FilledButton.tonal(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey;
                }
                return Colors.white;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            onPressed: openContainer,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )));
  }
}
