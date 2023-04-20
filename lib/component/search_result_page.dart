import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'group_landing.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var searchString = TextEditingController();
  String textToDisplay = '';
  Stream streamQuery = Stream.empty();
  @override
  void initState() {
    // <- here

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(225, 214, 246, 1),
                    borderRadius: BorderRadius.circular(15)),
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            filled: true,
                            fillColor: Color.fromRGBO(225, 214, 246, 1),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                          ),
                          controller: searchString,
                          onChanged: (value) => setState(() {
                            streamQuery = FirebaseFirestore.instance
                                .collection("groups")
                                .where("searchParam",
                                    arrayContains: value.toLowerCase())
                                .snapshots();
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: streamQuery,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        print(snapshot.data!.docs.length);
                        if (snapshot.data!.docs.length == 0)
                          return const Center(
                            child: Text("No result found"),
                          );
                        else
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final doc = snapshot.data!.docs[index];
                                return FilledButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GroupLanding(
                                                  title: doc["title"],
                                                  course: doc["course"],
                                                  location: doc["location"],
                                                  members: doc["members"],
                                                  id: doc.id,
                                                ))),
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Text(doc["title"]),
                                          Text(doc["course"]),
                                          Text(doc["location"]),
                                          Text(
                                              "Member : ${doc['members'].length}")
                                        ],
                                      ),
                                    ));
                              });
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator()));
                      } else {
                        return const Center(
                          child: Text(""),
                        );
                      }
                    }),
              )
            ],
          ),
        )));
  }
}
