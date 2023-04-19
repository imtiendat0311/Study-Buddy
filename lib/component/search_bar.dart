import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchBar extends StatelessWidget {
  final String searchString;
  final VoidCallback openContainer;

  const SearchBar(
      {super.key, required this.searchString, required this.openContainer});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: openContainer, child: Text("Search"));
  }
}
