import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';
import 'package:the_movie/presentation/movie/screen/movie_detail_screen.dart';

import '../../../data/models/search/search_multi.dart';
import '../../../main.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBarWidget({super.key, required this.controller, required this.focusNode});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> with RouteAware {

  Future<List<SearchMulti>> _getSuggestions(String query) async {
    try {
      if (!widget.focusNode.hasFocus) {
        return [];
      }
      return SearchRepositoryImpl.instance.getSearchMutil(query);
    } catch (e) {
      throw Exception(e);
    }
  }

  IconData getIcon(String? mediaType) {
    switch (mediaType) {
      case 'movie':
        return Icons.movie;
      case 'tv':
        return Icons.tv;
      default:
        return Icons.person;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    widget.focusNode.unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.containerWhite,
      ),
      child: TypeAheadField(
        // Tránh gọi api liên tục khi người dùng nhập
        debounceDuration: const Duration(milliseconds: 500),
        controller: widget.controller,
        focusNode: widget.focusNode,
        builder: (context, controller, focusNode) => TextField(
          style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
            color: AppColors.textBlack,
          ),
          onSubmitted: (value) {
            FocusScope.of(context).unfocus();
            AppNavigator.pushAndRemove(context,
                DetailSearchScreen(query: widget.controller.text, index: 0));
          },
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            hintText: AppStrings.search.tr(),
            hintStyle: TextManager.textStyleMedium(TextSizes.s16)
                .copyWith(color: AppColors.textBlack),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: controller.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return await _getSuggestions(pattern);
        },
        constraints: BoxConstraints(maxHeight: HeightSizes.h300),
        itemBuilder: (context, value) {
          return ListTile(
            leading: Icon(getIcon(value.mediaType)),
            title: Text((value.originalName ?? value.name ?? "").toString()),
          );
        },
        onSelected: (value) {
          FocusScope.of(context).unfocus();
          AppNavigator.push(
              context,
              MovieDetailScreen(
                  id: value.id!, isMovie: value.mediaType == "movie"));
        },
      ),
    );
  }
}
