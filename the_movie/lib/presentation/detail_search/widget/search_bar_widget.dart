import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: const Icon(Icons.search, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            )),
      ),
    );
  }
}