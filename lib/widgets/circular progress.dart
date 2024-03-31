import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class CircularProg extends CustomPainter {
  const CircularProg({
    this.val = 10,
    this.color = Colors.indigoAccent,
  }) : super();

  final double val;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);
    double set = 50;

    // Draw the gray background seen on the progress indicator
    // This will act as the background layer.
    canvas.drawCircle(
      center,
      58 - set / 2,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.tealAccent
        ..strokeWidth = 6,
    );

    // Create a new layer where we will be painting the
    // actual progress indicator
    canvas.saveLayer(
      Rect.fromCenter(center: center, width: 145 - set, height: 145 - set),
      Paint(),
    );

    // Draw the light green portion of the progress indicator
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 115 - set, height: 115 - set),
      vmath.radians(90),
      vmath.radians(val),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = color
        ..strokeWidth = 8,
    );

    // Draw the dark green portion of the progress indicator
    // Basically, this covers the entire progress indicator circle.
    // But because we have set the blending mode to srouce-in (BlendMode.srcIn),
    // only the segment that is overlapping with the lighter portion will be visible.
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 100 - set, height: 100 - set),
      vmath.radians(0),
      vmath.radians(360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = ecosperity
        ..strokeWidth = 10
        ..blendMode = BlendMode.srcIn,
    );
    // we fatten the layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
