import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/detail_search/widget/company_widget.dart';


class TabCompany extends StatefulWidget {
  final String query;

  const TabCompany({super.key, required this.query});

  @override
  State<TabCompany> createState() => _TabCompanyState();
}

class _TabCompanyState extends State<TabCompany> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p24),
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerManager.horizontalDivider,
              GapsManager.h5,
              const CompanyWidget(
                logoPath: '',
                originCountry: 'US',
                name: 'Ready',
              ),
              GapsManager.h10,
              DividerManager.horizontalDivider,
            ],
          )),
    );
  }
}