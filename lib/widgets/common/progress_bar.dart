import 'package:flutter/material.dart';
import '../../config/theme.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final int segments;
  final bool showGlow;
  final Color? fillColor;
  final Color? backgroundColor;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
    this.segments = 10,
    this.showGlow = false, // Default false for flat theme
    this.fillColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(segments, (index) {
        final segmentProgress = (progress * segments) - index;
        final isFilled = segmentProgress >= 1.0;
        final isPartiallyFilled = segmentProgress > 0 && segmentProgress < 1.0;

        return Expanded(
          child: Container(
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: isFilled || isPartiallyFilled
                  ? fillColor ?? SoloLevelingTheme.primary
                  : backgroundColor ?? SoloLevelingTheme.border,
              borderRadius: BorderRadius.circular(1), // Sharper corners for system look
              // Glow removed for flat design parity
            ),
            child: isPartiallyFilled
                ? FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: segmentProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: fillColor ?? SoloLevelingTheme.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            )
                : null,
          ),
        );
      }),
    );
  }
}