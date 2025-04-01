import 'package:flutter/material.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';

class KeyWordWidget1 extends StatefulWidget {
  final List<Keyword> keywords;

  const KeyWordWidget1({
    super.key,
    required this.keywords,
  });

  @override
  State<KeyWordWidget1> createState() => _KeyWordWidget1State();
}

class _KeyWordWidget1State extends State<KeyWordWidget1> {
  int? selectedKeywordId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.keywords.map((keyword) {
            final isSelected = selectedKeywordId == keyword.id;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedKeywordId = keyword.id;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade100
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    keyword.name ?? '',
                    style: TextStyle(
                      color: isSelected ? Colors.blue.shade800 : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
