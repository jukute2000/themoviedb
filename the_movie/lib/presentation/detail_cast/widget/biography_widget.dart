import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RichText(
        textAlign: TextAlign.center,
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
    );
  }
}
