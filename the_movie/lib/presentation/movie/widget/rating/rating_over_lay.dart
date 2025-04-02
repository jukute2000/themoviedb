import 'package:flutter/material.dart';

class RatingOverlay extends StatefulWidget {
  final double initialScore;
  final Function(double) onRatingSelected;
  final Function(double) resetRating;

  const RatingOverlay({
    super.key,
    required this.initialScore,
    required this.onRatingSelected,
    required this.resetRating,
  });

  @override
  State<RatingOverlay> createState() => _RatingOverlayState();
}

class _RatingOverlayState extends State<RatingOverlay> {
  late double rating;
  late Map<String, IconData> moodIcons;
  late String selectedMood;

  @override
  void initState() {
    super.initState();
    rating = widget.initialScore;
    moodIcons = {
      "Happy": Icons.emoji_emotions,
      "Interested": Icons.lightbulb,
      "Surprised": Icons.sentiment_satisfied_alt,
      "Sad": Icons.sentiment_dissatisfied,
    };
    selectedMood = "Happy"; // Default selected mood
  }

  // Get color based on rating value (red to green gradient)
  Color getRatingColor(double value) {
    // From red (0) to yellow (50) to green (100)
    if (value <= 50) {
      // From red to yellow (0-50)
      return Color.lerp(Colors.red, Colors.yellow, value / 50)!;
    } else {
      // From yellow to green (50-100)
      return Color.lerp(Colors.yellow, Colors.green, (value - 50) / 50)!;
    }
  }

  String getRatingText(double value) {
    if (value < 20) return "Rất không hài lòng";
    if (value < 40) return "Không hài lòng";
    if (value < 60) return "Bình thường";
    if (value < 80) return "Hài lòng";
    return "Rất hài lòng";
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = getRatingColor(rating);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Đánh giá của bạn",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      currentColor.withOpacity(0.2), // sua lai thanh with value
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: currentColor, width: 1),
                ),
                child: Text(
                  "${rating.toInt()}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: currentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            getRatingText(rating),
            style: TextStyle(
              fontSize: 16,
              color: currentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: currentColor,
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: currentColor,
              overlayColor: currentColor.withOpacity(0.2),
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            ),
            child: Slider(
              value: rating,
              min: 0,
              max: 100,
              divisions: 10, // 10 divisions from 0-100 (0, 10, 20, ..., 100)
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0%", style: TextStyle(color: Colors.grey.shade600)),
              Text("100%", style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                widget.resetRating(rating / 10);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text("Đặt lại"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Tâm trạng của bạn",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: moodIcons.entries.map((entry) {
              final bool isSelected = selectedMood == entry.key;
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedMood = entry.key;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? currentColor.withOpacity(0.2)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? currentColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        entry.value,
                        size: 36,
                        color: isSelected ? currentColor : Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color:
                              isSelected ? currentColor : Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                widget.onRatingSelected(rating / 10);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: currentColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 2,
              ),
              child: const Text(
                "Hoàn tất",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
