import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';

import '../../../core/comons/widgets/page_number.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (currentPage > 1)
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => onPageChanged(currentPage - 1),
          ),
        if (currentPage > 3)
          SizedBox(
            width: WidthSizes.w50,
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: PaddingSizes.p8),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                int page = int.tryParse(value) ?? 1;
                if (page > 0 && page <= totalPages) {
                  onPageChanged(page);
                }
              },
            ),
          ),
        if (currentPage <= 3)
          PageNumber(
            page: 1,
            isChoose: currentPage == 1,
            onPageChanged: (_) => onPageChanged(1),
          ),
        if (currentPage > 2)
          PageNumber(
            page: currentPage - 1,
            isChoose: false,
            onPageChanged: (_) => onPageChanged(currentPage - 1),
          ),
        if (currentPage != 1 && currentPage != totalPages)
          PageNumber(
            page: currentPage,
            isChoose: true,
            onPageChanged: (_) => onPageChanged(currentPage),
          ),
        if (currentPage < totalPages - 1)
          PageNumber(
            page: currentPage + 1,
            isChoose: false,
            onPageChanged: (_) => onPageChanged(currentPage + 1),
          ),
        if (currentPage < totalPages - 2) const Text('...'),
        PageNumber(
          page: totalPages,
          isChoose: currentPage == totalPages,
          onPageChanged: (_) => onPageChanged(totalPages),
        ),
        if (currentPage < totalPages)
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => onPageChanged(currentPage + 1),
          ),
      ],
    );
  }
}
