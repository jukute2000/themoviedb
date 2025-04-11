import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../core/comons/extension/search_category.dart';
import '../../core/configs/assets/app_colors.dart';
import '../../core/configs/assets/app_images.dart';
import '../../core/configs/assets/app_strings.dart';
import '../../core/configs/navigation/app_navigation.dart';
import '../detail_search/widget/search_bar_widget.dart';
import '../profile/screen/profile_screen.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required ScrollController scrollController,
    required this.body,
    required this.isHome,
    required this.isSearch,
    this.controller,
    this.tabController, this.focusNode,

  }) : _scrollController = scrollController;

  final FocusNode? focusNode;
  final ScrollController _scrollController;
  final Widget body;
  final bool isHome;
  final bool isSearch;
  final TextEditingController? controller;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          backgroundColor: AppStyleProvider.of(context).backgroundColor(),
          title: GestureDetector(
            onTap: () {
              AppNavigator.pushAndRemove(context, const HomeScreen());
            },
            child: SvgPicture.network(
              AppImages.logoAppBar,
              height: 18.h,
              colorFilter: const ColorFilter.mode(
                AppColors.iconAppbar,
                BlendMode.srcIn,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () =>
                  AppNavigator.push(context, const ProfileScreen()),
            ),
            if (!isHome)
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: AppColors.iconSerach,
                ),
              )
          ],
        ),
        if (isSearch) ...[
          SliverPersistentHeader(
            floating: false,
            pinned: true,
            delegate: _SearchBarDelegate(
                controller: controller ?? TextEditingController(),
              focusNode: focusNode ?? FocusNode(),
            ),
          ),
          SliverAppBar(
              backgroundColor: AppStyleProvider.of(context).backgroundColor(),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              pinned: false,
              floating: true,
              snap: true,
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyleProvider.of(context).iconColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(RadiusSizes.r16),
                  ),
                ),
                onPressed: () {
                  AppNavigator.pushAndRemove(
                      context,
                      DetailSearchScreen(
                          query: controller?.text ?? "", index: 0));
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.search.tr(),
                    style: TextManager.textStyleMedium(TextSizes.s16).copyWith(
                        color: AppStyleProvider.of(context).textColor()),
                  ),
                ),
              ),
              bottom: TabBar(
                labelColor: AppStyleProvider.of(context).iconColor(),
                unselectedLabelColor: AppColors.textWhite,
                indicatorColor: AppColors.iconAppbar,
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                controller: tabController,
                tabs: SearchCategory.values.map((category) {
                  return buildTab(
                    category.localizedName,
                  );
                }).toList(),
              ))
        ]
      ],
      body: body,
    );
  }

  Tab buildTab(String title) {
    return Tab(
      child: Text(
        title,
        style: TextManager.textStyleMedium(TextSizes.s16),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;
  final FocusNode focusNode;

  _SearchBarDelegate({required this.controller, required this.focusNode});

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: SearchBarWidget(
        controller: controller,
        focusNode: focusNode,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
