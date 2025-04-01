import 'dart:async';
import 'package:flutter/widgets.dart';

import '../../../core/comons/extension/search_category.dart';



class SearchTotalProvider extends StatefulWidget {
  final Widget child;
  const SearchTotalProvider({super.key, required this.child});

  static _SearchTotalProviderState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedSearchTotal>()?.data;
  }

  @override
  State<SearchTotalProvider> createState() => _SearchTotalProviderState();
}

class _SearchTotalProviderState extends State<SearchTotalProvider> {
  final StreamController<Map<String, int>> _totalResultsController =
  StreamController.broadcast();

  final Map<String, int> _totalResults = {
    SearchCategory.tv.name: 0,
    "movie": 0,
    "people": 0,
    "collections": 0,
    "keywords": 0,
    "companies": 0,
  };
  Stream<Map<String, int>> get totalResultsStream => _totalResultsController.stream;
  Map<String, int> get totalResults => _totalResults;

  void updateTotal(String category, int? total) {
    _totalResults[category] = total ?? 0;
    _totalResultsController.add(Map.from(_totalResults)); // Cập nhật Stream
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedSearchTotal(
      data: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _totalResultsController.close();
    super.dispose();
  }
}

class _InheritedSearchTotal extends InheritedWidget {
  final _SearchTotalProviderState data;

  const _InheritedSearchTotal({
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(_InheritedSearchTotal oldWidget) {
    return true;
  }
}
