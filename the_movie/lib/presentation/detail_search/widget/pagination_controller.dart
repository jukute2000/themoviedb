import 'package:flutter/material.dart';

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
        PageNumber(
          page: 1,
          isChoose: currentPage == 1,
          onPageChanged: (_) => onPageChanged(1),
        ),
        if (currentPage > 3) const Text('...'),
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