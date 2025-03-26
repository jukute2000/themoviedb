import 'package:flutter/material.dart';
import 'package:the_movie/presentation/detail_search/widget/people_widget.dart';


class TabPeople extends StatefulWidget {
  final String query;

  const TabPeople({super.key, required this.query});

  @override
  State<TabPeople> createState() => _TabPeopleState();
}

class _TabPeopleState extends State<TabPeople> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => PeopleWidget(
          knownForDepartment: 'Acting',
          name: 'Michael Keaton',
          knownFor: ['Batman', 'Birdman', 'Spotlight', 'Beetlejuice', 'Jack Frost'],
          profilePath: '',
        ));
  }
}