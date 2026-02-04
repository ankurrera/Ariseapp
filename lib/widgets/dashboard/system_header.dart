import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/user_profile.dart';
import '../../widgets/common/glow_text.dart';

class SystemHeader extends StatelessWidget {
  final UserProfile profile;

  const SystemHeader({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: SoloLevelingTheme.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: SoloLevelingTheme.glowBlue.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlowText(
                    text: profile.displayName ?? 'Hunter',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.playerClass.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 2,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'LEVEL',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '${profile.level}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
