import 'package:flutter/material.dart';
import 'package:the_movie/presentation/detail_search/widget/people_widget.dart';

import '../../../../../data/models/people/people.dart';
import '../../../../../data/models/search/search_people.dart';
import '../../../widget/pagination_controller.dart';

class TabPeople extends StatefulWidget {
  final SearchPeople peopleData;
  final Function(int?) onPageChanged;

  const TabPeople({super.key, required this.peopleData, required this.onPageChanged});

  @override
  State<TabPeople> createState() => _TabPeopleState();
}

class _TabPeopleState extends State<TabPeople> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.peopleData.peoples?.length,
              itemBuilder: (context, index) {
                People? people = widget.peopleData.peoples?[index];
                return PeopleWidget(
                  knownForDepartment: people?.knownForDepartment,
                  name: people?.name,
                  knownFor: people?.knowFors,
                  profilePath: people?.profilePath,
                );
              }),
        ),
        PaginationControls(
          currentPage: widget.peopleData.page ?? 1,
          totalPages: widget.peopleData.totalPages ?? 1,
          onPageChanged: widget.onPageChanged,
        ),
      ],
    );
  }
}
