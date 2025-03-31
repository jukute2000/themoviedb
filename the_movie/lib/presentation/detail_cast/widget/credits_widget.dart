import 'package:flutter/material.dart';
import 'package:the_movie/core/utils/divider_manager.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/data/models/medias/media.dart';

class CreditsWidget extends StatefulWidget {
  const CreditsWidget({super.key, required this.medias});
  final List<Media> medias;
  @override
  State<CreditsWidget> createState() => _CreditsWidgetState();
}

class _CreditsWidgetState extends State<CreditsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GapsManager.h10,
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.medias.length,
          itemBuilder: (context, index) {
            Media media = widget.medias[index];
            int currentYear = int.tryParse(media.getYear()) ?? 0;
            int previousYear = index > 0
                ? int.tryParse(widget.medias[index - 1].getYear()) ?? 0
                : currentYear;
            return Column(
              children: [
                if (index > 0 && currentYear != previousYear)
                  DividerManager.horizontalDivider,
                ListTile(
                  leading: Text(
                    media.getYear(),
                  ),
                  title: Text(media.getTitle() ?? "Unknow"),
                  subtitle: Text(media.charater ?? ""),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
