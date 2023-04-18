import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MapComp extends StatelessWidget {
  final String title;
  final VoidCallback openContainer;

  const MapComp({super.key, required this.title, required this.openContainer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(title),
    );
  }
}
