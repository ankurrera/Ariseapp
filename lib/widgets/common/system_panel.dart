import 'package:flutter/material.dart';
import '../../config/theme.dart';

class SystemPanel extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsetsGeometry padding;

  const SystemPanel({
    super.key,
    required this.child,
    this.title,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SoloLevelingTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SoloLevelingTheme.border, width: 1),
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: padding,
            child: child,
          ),

          // Corner Decorations
          const Positioned(top: 0, left: 0, child: _Corner(isTop: true, isLeft: true)),
          const Positioned(top: 0, right: 0, child: _Corner(isTop: true, isLeft: false)),
          const Positioned(bottom: 0, left: 0, child: _Corner(isTop: false, isLeft: true)),
          const Positioned(bottom: 0, right: 0, child: _Corner(isTop: false, isLeft: false)),
        ],
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  final bool isTop;
  final bool isLeft;

  const _Corner({required this.isTop, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    const double size = 8.0;
    const double thickness = 1.0;
    const Color color = SoloLevelingTheme.border; // Subtle border color

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerPainter(isTop, isLeft, color, thickness),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;
  final Color color;
  final double thickness;

  _CornerPainter(this.isTop, this.isLeft, this.color, this.thickness);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final path = Path();

    // Draw L shapes depending on corner
    if (isTop && isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (isTop && !isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else { // Bottom Right
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}