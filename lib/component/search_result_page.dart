import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/component/search_bar.dart';
import 'package:study_buddy/component/search_page.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                OpenContainer(
                  openBuilder: (_, closeContainer) => SearchPage(
                      onClose: closeContainer as void Function(
                          {String returnValue})),
                  onClosed: (res) => setState(() {
                    if (res != null) {
                      searchString = res as String;
                    }
                  }),
                  closedBuilder: (_, openContainer) => SearchBar(
                    searchString: searchString,
                    openContainer: openContainer,
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
