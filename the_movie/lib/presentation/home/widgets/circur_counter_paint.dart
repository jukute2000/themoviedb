import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircleCounterAnimation extends StatefulWidget {
  final Color circleColor;
  final Color textColor;
  final double size;
  final Duration duration;

  const CircleCounterAnimation({
    super.key,
    this.circleColor = Colors.blue,
    this.textColor = Colors.black,
    this.size = 150.0,
    this.duration = const Duration(seconds: 2),
  });

  @override
  CircleCounterAnimationState createState() => CircleCounterAnimationState();
}

class CircleCounterAnimationState extends State<CircleCounterAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _counterAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _circleAnimation = Tween<double>(
      begin: 0,
      end: 360,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    _counterAnimation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: CircleArcPainter(
                sweepAngle: _circleAnimation.value * math.pi / 180,
                color: widget.circleColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _counterAnimation.value.toInt().toString(),
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.size * 0.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleArcPainter extends CustomPainter {
  final double sweepAngle;
  final Color color;

  CircleArcPainter({required this.sweepAngle, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CircleArcPainter oldDelegate) {
    return oldDelegate.sweepAngle != sweepAngle || oldDelegate.color != color;
  }
}

class CounterAnimationScreen extends StatelessWidget {
  const CounterAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Counter Animation')),
      body: const Center(
        child: CircleCounterAnimation(
          circleColor: Colors.blue,
          textColor: Colors.black,
          size: 200.0,
          duration: Duration(seconds: 3),
        ),
      ),
    );
  }
}
