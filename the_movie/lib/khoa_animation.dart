import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';

class KhoaAnimation extends StatefulWidget {
  const KhoaAnimation({super.key});

  @override
  State<KhoaAnimation> createState() => _KhoaAnimationState();
}

class _KhoaAnimationState extends State<KhoaAnimation>
    with TickerProviderStateMixin {
  // Background
  late AnimationController _bgController;
  late Animation<Color?> _bgColor1;
  late Animation<Color?> _bgColor2;

  // Text bay lên
  late AnimationController _textController;
  late Animation<Offset> _textOffset;
  late Animation<double> _textOpacity;

  // Fill tim từ dưới lên
  late AnimationController _fillController;
  late Animation<double> _fillAnimation;

  // Tim rung nhẹ
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  // Glow xung quanh
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    // Gradient background
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _bgColor1 = ColorTween(begin: Colors.blue, end: Colors.purple).animate(_bgController);
    _bgColor2 = ColorTween(begin: Colors.orange, end: Colors.pink).animate(_bgController);

    // Text animation
    _textController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    _textOffset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(_textController);

    // Tim fill
    _fillController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _fillAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fillController, curve: Curves.easeInOut),
    );

    // Shake
    _shakeController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _shakeAnimation = Tween<double>(begin: -4.0, end: 4.0).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    // Glow
    _glowController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  void toggleLike() {
    setState(() => isLiked = !isLiked);
    if (isLiked) {
      _fillController.forward();
      _shakeController.forward(from: 0);
    } else {
      _fillController.reverse();
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _textController.dispose();
    _fillController.dispose();
    _shakeController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 80.sp;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_bgController, _textController]),
        builder: (_, __) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_bgColor1.value!, _bgColor2.value!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SlideTransition(
                    position: _textOffset,
                    child: FadeTransition(
                      opacity: _textOpacity,
                      child: Text(
                        "🔥 Thả tim 🔥",
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GapsManager.h40,
                  GestureDetector(
                    onTap: toggleLike,
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_fillController, _shakeController, _glowController]),
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_shakeAnimation.value, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: isLiked
                                  ? [
                                BoxShadow(
                                  color: Colors.red.withOpacity(_glowAnimation.value),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                ),
                              ]
                                  : [],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: iconSize,
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                ClipRect(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    heightFactor: _fillAnimation.value,
                                    child: Icon(
                                      Icons.favorite,
                                      size: iconSize,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
