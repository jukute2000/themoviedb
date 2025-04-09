import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/configs/assets/app_colors.dart';

class ScoreAnimation extends StatefulWidget {
  const ScoreAnimation({super.key, required this.score});
  final int score;
  @override
  State<ScoreAnimation> createState() => _ScoreAnimationState();
}

class _ScoreAnimationState extends State<ScoreAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late IntTween _tween;

  @override
  void initState() {
    _tween = IntTween(begin: 0, end: widget.score);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = _tween
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color progressColor = widget.score >= 7
        ? AppColors.ratingGreen
        : widget.score >= 5
            ? AppColors.ratingYellow
            : AppColors.ratingyellowhigh;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 45.w,
              height: 45.h,
              child: CircularProgressIndicator(
                value: _animation.value / 100,
                backgroundColor: AppColors.textGreyShade800,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                strokeWidth: 4,
              ),
            ),
            Text(
              "${_animation.value}%",
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
