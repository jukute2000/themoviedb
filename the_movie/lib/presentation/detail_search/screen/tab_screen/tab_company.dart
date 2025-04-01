import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/presentation/detail_search/widget/company_widget.dart';

import '../../../../core/comons/widgets/page_number.dart';
import '../../../../data/models/company/company.dart';

class TabCompany extends StatefulWidget {
  final SearchCompanies companyData;
  final Function(int?) onPageChanged;

  const TabCompany(
      {super.key, required this.companyData, required this.onPageChanged});

  @override
  State<TabCompany> createState() => _TabCompanyState();
}

class _TabCompanyState extends State<TabCompany> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p24),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.companyData.companies?.length,
                itemBuilder: (context, index) {
                  Company? company = widget.companyData.companies?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DividerManager.horizontalDivider,
                      GapsManager.h5,
                      CompanyWidget(
                        logoPath: company?.logoPath,
                        originCountry: company?.originCountry,
                        name: company?.name ?? '',
                      ),
                      GapsManager.h10,
                      DividerManager.horizontalDivider,
                    ],
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.companyData.page! > 1)
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    widget.onPageChanged(widget.companyData.page! - 1);
                  },
                ),
              PageNumber(
                page: 1,
                isChoose: widget.companyData.page == 1,
                onPageChanged: (_) {
                  widget.onPageChanged(1);
                },
              ),
              if (widget.companyData.page! > 3) Text('...'),
              if (widget.companyData.page! > 2)
                PageNumber(
                  page: widget.companyData.page! - 1,
                  isChoose: false,
                  onPageChanged: (_) {
                    widget.onPageChanged(widget.companyData.page! - 1);
                  },
                ),
              if (widget.companyData.page != 1 &&
                  widget.companyData.page != widget.companyData.totalPages)
                PageNumber(
                  page: widget.companyData.page!,
                  isChoose: true,
                  onPageChanged: (_) {
                    widget.onPageChanged(widget.companyData.page!);
                  },
                ),
              if (widget.companyData.page! < widget.companyData.totalPages! - 1)
                PageNumber(
                  page: widget.companyData.page! + 1,
                  isChoose: false,
                  onPageChanged: (_) {
                    widget.onPageChanged(widget.companyData.page! + 1);
                  },
                ),
              if (widget.companyData.page! < widget.companyData.totalPages! - 2)
                Text('...'),
              PageNumber(
                page: widget.companyData.totalPages,
                isChoose:
                    widget.companyData.page == widget.companyData.totalPages,
                onPageChanged: (_) {
                  widget.onPageChanged(widget.companyData.totalPages);
                },
              ),
              if ((widget.companyData.page ?? 0) <
                  (widget.companyData.totalPages ?? 0))
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    widget.onPageChanged(widget.companyData.page! + 1);
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}
