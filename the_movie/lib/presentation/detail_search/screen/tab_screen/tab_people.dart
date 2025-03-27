import 'package:flutter/material.dart';
import 'package:the_movie/data/models/search/search_people/people.dart';
import 'package:the_movie/data/models/search/search_people/search_people.dart';
import 'package:the_movie/presentation/detail_search/widget/people_widget.dart';

import '../../../../core/comons/widgets/page_number.dart';

class TabPeople extends StatefulWidget {
  final SearchPeople peopleData;
  final Function(int) onPageChanged;

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
              itemCount: widget.peopleData.peoples.length,
              itemBuilder: (context, index) {
                People people = widget.peopleData.peoples[index];
                return PeopleWidget(
                  knownForDepartment: people.knownForDepartment,
                  name: people.name,
                  knownFor: people.knowFors,
                  profilePath: people.profilePath,
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.peopleData.page > 1)
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  widget.onPageChanged(widget.peopleData.page - 1);
                },
              ),
            PageNumber(
              page: 1,
              isChoose: widget.peopleData.page == 1,
              onPageChanged: (_) {
                widget.onPageChanged(1);
              },
            ),
            if (widget.peopleData.page > 3) Text('...'),
            if (widget.peopleData.page > 2)
              PageNumber(
                page: widget.peopleData.page - 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.peopleData.page - 1);
                },
              ),
            if (widget.peopleData.page != 1 &&
                widget.peopleData.page != widget.peopleData.totalPages)
              PageNumber(
                page: widget.peopleData.page,
                isChoose: true,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.peopleData.page);
                },
              ),
            if (widget.peopleData.page < widget.peopleData.totalPages - 1)
              PageNumber(
                page: widget.peopleData.page + 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.peopleData.page + 1);
                },
              ),
            if (widget.peopleData.page < widget.peopleData.totalPages - 2)
              Text('...'),
            PageNumber(
              page: widget.peopleData.totalPages,
              isChoose: widget.peopleData.page == widget.peopleData.totalPages,
              onPageChanged: (_) {
                widget.onPageChanged(widget.peopleData.totalPages);
              },
            ),
            if (widget.peopleData.page < widget.peopleData.totalPages)
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  widget.onPageChanged(widget.peopleData.page + 1);
                },
              ),
          ],
        )
      ],
    );
  }
}
