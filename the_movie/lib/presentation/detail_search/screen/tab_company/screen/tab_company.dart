import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/comons/extension/search_category.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/presentation/detail_search/screen/tab_company/bloc/tab_company_state.dart';
import 'package:the_movie/presentation/detail_search/widget/company_widget.dart';

import '../../../../../data/models/company/company.dart';
import '../../../stream_controller/search_total_provider.dart';
import '../../../widget/pagination_controller.dart';
import '../bloc/tab_company_cubit.dart';

class TabCompany extends StatefulWidget {
  final String query;
  final int totalResults;

  const TabCompany({super.key, required this.query, required this.totalResults});

  @override
  State<TabCompany> createState() => _TabCompanyState();
}

class _TabCompanyState extends State<TabCompany>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TabCompanyCubit>().fetchCompanies(widget.query, 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TabCompanyCubit, TabCompanyState>(
        builder: (context, state) {
      if (state is TabCompanyLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TabCompanyLoaded) {
        final searchTotalProvider = SearchTotalProvider.of(context);
        if (searchTotalProvider != null) {
          searchTotalProvider.updateTotal(
            SearchCategory.companies.name,
            state.companyData.totalResults,
          );
        } else {
          debugPrint("⚠️ Warning: SearchTotalProvider không được tìm thấy!");
        }
        return state.companyData.companies != null
            ? Padding(
                padding: EdgeInsets.all(PaddingSizes.p24),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.companyData.companies?.length,
                          itemBuilder: (context, index) {
                            Company? company =
                                state.companyData.companies?[index];
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
                      currentPage: state.page,
                      totalPages: state.companyData.totalPages ?? 1,
                      onPageChanged: (newPage) {
                        context
                            .read<TabCompanyCubit>()
                            .fetchCompanies(widget.query, newPage);
                      },
                    ),
                  ],
                ),
              )
            : const Center(child: Text("No data"));
      } else if (state is TabCompanyError) {
        return Center(child: Text(state.message));
      }
      return const Center(child: Text("No data"));
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
