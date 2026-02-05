import 'package:flutter/material.dart';
import 'dart:math';
import '../../config/theme.dart';
import '../common/system_panel.dart';

class RadarChart extends StatelessWidget {
  const RadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder data - In production, connect this to your Riverpod skills provider
    final skills = [
      {'name': 'Strength', 'value': 1500},
      {'name': 'Agility', 'value': 1200},
      {'name': 'Sense', 'value': 800},
      {'name': 'Vitality', 'value': 1800},
      {'name': 'Intelligence', 'value': 600},
    ];

    return SystemPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              painter: _RadarChartPainter(skills),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Showing ${skills.length} skill axes. Click to see details.",
            style: SoloLevelingTheme.systemFont.copyWith(
              fontSize: 12,
              color: SoloLevelingTheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> skills;
  final double maxValue;

  // Matching web: MAX_SKILL_XP = 2000
  _RadarChartPainter(this.skills) : maxValue = 2000.0;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    // Padding matching the "radius - 60" from web logic relative to size
    final radius = min(centerX, centerY) - 30;
    final numAxes = skills.length;

    if (numAxes == 0) return;

    final center = Offset(centerX, centerY);

    // ---------------------------------------------------------
    // 1. Draw Grid Rings (Polygonal, not circular)
    // Web: levels = 10, strokeStyle = "#E6E6E6", lineWidth = 0.5
    // ---------------------------------------------------------
    final gridPaint = Paint()
      ..color = const Color(0xFFE6E6E6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const levels = 10;
    for (int i = 1; i <= levels; i++) {
      final levelRadius = (radius / levels) * i;
      final path = Path();

      for (int j = 0; j <= numAxes; j++) {
        final angle = (pi * 2 * j) / numAxes - pi / 2;
        final x = centerX + cos(angle) * levelRadius;
        final y = centerY + sin(angle) * levelRadius;
        if (j == 0) path.moveTo(x, y);
        else path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // ---------------------------------------------------------
    // 2. Draw Axes Lines
    // Web: strokeStyle = "#D0D0D0", lineWidth = 0.5
    // ---------------------------------------------------------
    final axisPaint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // ---------------------------------------------------------
    // Labels & Values Config
    // Web Labels: font "10px sans-serif", fill "#8E8E8E"
    // Web Values: font "8px sans-serif", fill "#9A9A9A"
    // ---------------------------------------------------------
    final labelStyle = SoloLevelingTheme.systemFont.copyWith(
      fontSize: 10,
      color: const Color(0xFF8E8E8E),
      fontWeight: FontWeight.w300,
    );

    final valueStyle = SoloLevelingTheme.systemFont.copyWith(
      fontSize: 8,
      color: const Color(0xFF9A9A9A),
      fontWeight: FontWeight.w300,
    );

    for (int i = 0; i < numAxes; i++) {
      final angle = (pi * 2 * i) / numAxes - pi / 2;
      final x = centerX + cos(angle) * radius;
      final y = centerY + sin(angle) * radius;

      // Draw axis line
      canvas.drawLine(center, Offset(x, y), axisPaint);

      // Draw Label (Name)
      final labelRadius = radius + 20;
      final labelX = centerX + cos(angle) * labelRadius;
      final labelY = centerY + sin(angle) * labelRadius;

      _drawText(
          canvas,
          skills[i]['name'] as String,
          Offset(labelX, labelY),
          labelStyle
      );
    }

    // ---------------------------------------------------------
    // 3. Draw Data Polygon
    // Web Fill: "rgba(200, 200, 200, 0.42)"
    // Web Stroke: "#9B9B9B", lineWidth = 1.25
    // ---------------------------------------------------------
    final dataPath = Path();
    final dataPoints = <Offset>[];

    for (int i = 0; i < numAxes; i++) {
      final angle = (pi * 2 * i) / numAxes - pi / 2;
      final value = (skills[i]['value'] as num).toDouble();
      final normalized = value / maxValue;
      final r = radius * normalized;

      final x = centerX + cos(angle) * r;
      final y = centerY + sin(angle) * r;
      final point = Offset(x, y);

      dataPoints.add(point);

      if (i == 0) dataPath.moveTo(x, y);
      else dataPath.lineTo(x, y);
    }
    dataPath.close();

    // Fill
    final fillPaint = Paint()
      ..color = const Color.fromRGBO(200, 200, 200, 0.42)
      ..style = PaintingStyle.fill;
    canvas.drawPath(dataPath, fillPaint);

    // Stroke
    final strokePaint = Paint()
      ..color = const Color(0xFF9B9B9B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25;
    canvas.drawPath(dataPath, strokePaint);

    // ---------------------------------------------------------
    // 4. Draw Value Numbers at Vertices
    // ---------------------------------------------------------
    for (int i = 0; i < numAxes; i++) {
      final angle = (pi * 2 * i) / numAxes - pi / 2;
      final point = dataPoints[i];

      // Offset values slightly outward from the vertex
      final valueOffset = 10.0;
      final valX = point.dx + cos(angle) * valueOffset;
      final valY = point.dy + sin(angle) * valueOffset;

      _drawText(
          canvas,
          (skills[i]['value'] as int).toString(),
          Offset(valX, valY),
          valueStyle
      );
    }

    // Draw Center Dot
    canvas.drawCircle(center, 2.0, Paint()..color = const Color(0xFF9A9A9A));
  }

  void _drawText(Canvas canvas, String text, Offset position, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    // Center the text on the position
    textPainter.paint(
        canvas,
        Offset(position.dx - textPainter.width / 2, position.dy - textPainter.height / 2)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}