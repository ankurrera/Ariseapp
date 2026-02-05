import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../config/theme.dart';

class SystemHeader extends StatelessWidget {
  const SystemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Navigation Label
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                '⚔ LVES',
                style: SoloLevelingTheme.systemFont.copyWith(
                  color: SoloLevelingTheme.primary,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          // Main Title
          Column(
            children: [
              Text(
                'SYSTEM',
                style: SoloLevelingTheme.gothicFont.copyWith(
                  fontSize: 42, // Adjusted for mobile
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                  color: SoloLevelingTheme.primary,
                  height: 1.0,
                ),
              ),
              Text(
                'STATUS',
                style: SoloLevelingTheme.gothicFont.copyWith(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                  color: SoloLevelingTheme.primary,
                  height: 1.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Subtitle
          Text(
            'PERSONAL TRAINING INTERFACE',
            style: SoloLevelingTheme.systemFont.copyWith(
              fontSize: 12,
              letterSpacing: 3.0,
              color: SoloLevelingTheme.mutedForeground,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Decorative Divider
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, SoloLevelingTheme.primary.withOpacity(0.5)],
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: SoloLevelingTheme.primary.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(0), // Diamond shape created by rotation
                ),
                transform: Matrix4.rotationZ(math.pi / 4),
              ),
              Container(
                width: 60,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [SoloLevelingTheme.primary.withOpacity(0.5), Colors.transparent],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}