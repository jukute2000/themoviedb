import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';

import '../../../core/configs/assets/app_strings.dart';

class BiographyWidget extends StatefulWidget {
  final String fullText;
  const BiographyWidget({super.key, required this.fullText});

  @override
  BiographyWidgetState createState() => BiographyWidgetState();
}

class BiographyWidgetState extends State<BiographyWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showToggle = widget.fullText.length > 200;
    String displayedText = _isExpanded || !showToggle
        ? widget.fullText
        : '${widget.fullText.substring(0, 200)}...';

    return Padding(
      padding: EdgeInsets.all(PaddingSizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.biography.tr(),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(
              text: displayedText,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
              children: [
                if (showToggle)
                  TextSpan(
                    text: _isExpanded ? " View Less" : " View More",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _toggleExpanded,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
