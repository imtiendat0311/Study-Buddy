import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MapPage extends StatelessWidget {
  final void Function({String returnValue}) onClosed;

  const MapPage({super.key, required this.onClosed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: SafeArea(
        child: Column(children: [
          Text("implement google map here"),
          FilledButton.tonal(onPressed: onClosed, child: Text("OKE"))
        ]),
      ),
    );
  }
}
