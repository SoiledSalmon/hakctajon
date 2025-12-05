import 'package:flutter/material.dart';
import 'dart:math';

class MeterGauge extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final int minAmount;
  final int maxAmount;

  const MeterGauge({
    super.key,
    required this.value,
    required this.minAmount,
    required this.maxAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: const Size(150, 75),
          painter: _MeterGaugePainter(value),
        ),
        const SizedBox(height: 12),
        Text(
          'Eligible Amount: ₹${minAmount.toStringAsFixed(0)} - ₹${maxAmount.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _MeterGaugePainter extends CustomPainter {
  final double value;

  _MeterGaugePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final gradient = SweepGradient(
      startAngle: pi,
      endAngle: 2 * pi,
      colors: [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.lightGreen,
        Colors.green,
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final foregroundPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw background semi-circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      backgroundPaint,
    );

    // Draw foreground arc based on value
    final sweepAngle = pi * value.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
