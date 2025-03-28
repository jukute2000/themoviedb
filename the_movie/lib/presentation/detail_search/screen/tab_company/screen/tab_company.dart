import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/presentation/detail_search/widget/company_widget.dart';

import '../../../../../data/models/company/company.dart';
import '../../../widget/pagination_controller.dart';

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
          PaginationControls(
            currentPage: widget.companyData.page ?? 1,
            totalPages: widget.companyData.totalPages ?? 1,
            onPageChanged: widget.onPageChanged,
          ),
        ],
      ),
    );
  }
}
