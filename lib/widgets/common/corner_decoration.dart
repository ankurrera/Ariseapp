import 'package:flutter/material.dart';
import '../../config/theme.dart';

enum Corner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class CornerDecoration extends StatelessWidget {
  final Corner corner;
  final double size;
  final Color? color;

  const CornerDecoration({
    super.key,
    required this.corner,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CornerPainter(
        corner: corner,
        color: color ?? SoloLevelingTheme.glowBlue,
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Corner corner;
  final Color color;

  _CornerPainter({
    required this.corner,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    switch (corner) {
      case Corner.topLeft:
        path.moveTo(size.width, 0);
        path.lineTo(0, 0);
        path.lineTo(0, size.height);
        break;
      case Corner.topRight:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        break;
      case Corner.bottomLeft:
        path.moveTo(size.width, size.height);
        path.lineTo(0, size.height);
        path.lineTo(0, 0);
        break;
      case Corner.bottomRight:
        path.moveTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width, 0);
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter oldDelegate) {
    return oldDelegate.corner != corner || oldDelegate.color != color;
  }
}
