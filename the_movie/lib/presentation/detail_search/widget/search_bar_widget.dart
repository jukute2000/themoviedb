import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/data/repositories/search_repository.dart';
import 'package:the_movie/presentation/detail_search/screen/detail_search_screen.dart';

import '../../../data/models/search/search_multi.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;

  const SearchBarWidget({super.key, required this.controller});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late FocusNode _focusNode;

  Future<List<SearchMulti>> _getSuggestions(String query) async {
    try {
      if (!_focusNode.hasFocus) {
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
  void initState() {
    // TODO: implement initState
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.containerWhite,
        child: TypeAheadField(
          // Tránh gọi api liên tục khi người dùng nhập
          debounceDuration: const Duration(milliseconds: 500),
          controller: widget.controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) => TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(RadiusSizes.r8))),
                hintText: AppStrings.search.tr(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          FocusScope.of(context).unfocus();
                        },
                      )),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailSearchScreen(
                          index: 1,
                          query: '',
                        ) // Vào DetailMovie,
                    ));
          },
        ));
  }
}
