import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';

import '../../../core/configs/assets/app_strings.dart';
import '../../theme/screen/app_style_provider.dart';

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
            style: TextManager.textStyleBlod(TextSizes.s20),
          ),
          RichText(
            text: TextSpan(
              text: displayedText,
              style: TextManager.textStyleRegular(TextSizes.s16)
                  .copyWith(color: AppStyleProvider.of(context).textColor()),
              children: [
                if (showToggle)
                  TextSpan(
                    text: _isExpanded ? " View Less" : " View More",
                    style: TextManager.textStyleRegular(TextSizes.s16).copyWith(
                      color: AppColors.textBlue,
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
