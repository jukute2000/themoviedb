import 'package:flutter/material.dart';
import 'package:the_movie/data/models/medias/tv.dart';
import 'package:the_movie/data/models/search/search_tv.dart';

import '../../../../core/comons/widgets/page_number.dart';
import '../../widget/tv_show_widget.dart';

class TabTvShow extends StatefulWidget {
  final SearchTv tvData;
  final Function(int?) onPageChanged;

  const TabTvShow({super.key, required this.tvData, required this.onPageChanged});

  @override
  State<TabTvShow> createState() => _TabTvShowState();
}

class _TabTvShowState extends State<TabTvShow> {
  @override
  Widget build(BuildContext context) {
    print(widget.tvData.page);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.tvData.results?.length,
              itemBuilder: (context, index) {
                TiVi tiVi = widget.tvData.results![index];
                return TvShowWidget(
                  title: tiVi.name,
                  originalName: tiVi.originalName,
                  releaseDate: tiVi.firstAirDate,
                  overview: tiVi.overview,
                  posterPath: tiVi.posterPath,
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.tvData.page! > 1)
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  widget.onPageChanged(widget.tvData.page! - 1);
                },
              ),
            PageNumber(
              page: 1,
              isChoose: widget.tvData.page == 1,
              onPageChanged: (_) {
                widget.onPageChanged(1);
              },
            ),
            if (widget.tvData.page! > 3) Text('...'),
            if (widget.tvData.page! > 2)
              PageNumber(
                page: widget.tvData.page! - 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.tvData.page! - 1);
                },
              ),
            if (widget.tvData.page != 1 &&
                widget.tvData.page != widget.tvData.totalPages)
              PageNumber(
                page: widget.tvData.page,
                isChoose: true,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.tvData.page);
                },
              ),
            if (widget.tvData.page! < widget.tvData.totalPages! - 1)
              PageNumber(
                page: widget.tvData.page! + 1,
                isChoose: false,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.tvData.page! + 1);
                },
              ),
            if (widget.tvData.page! < widget.tvData.totalPages! - 2)
              Text('...'),
            PageNumber(
              page: widget.tvData.totalPages,
              isChoose: widget.tvData.page == widget.tvData.totalPages,
              onPageChanged: (_) {
                widget.onPageChanged(widget.tvData.totalPages);
              },
            ),
            if ((widget.tvData.page ?? 0) <
                (widget.tvData.totalPages ?? 0))              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  widget.onPageChanged(widget.tvData.page! + 1);
                },
              ),
          ],
        )
      ],
    );
  }
}
