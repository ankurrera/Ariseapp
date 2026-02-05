import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/user_profile.dart';
import '../../widgets/common/system_panel.dart';
import '../../widgets/common/progress_bar.dart';

class PlayerStatusPanel extends StatelessWidget {
  final UserProfile profile;

  const PlayerStatusPanel({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    // Prevent division by zero
    final xpProgress = profile.xpToNextLevel > 0
        ? profile.currentXp / profile.xpToNextLevel
        : 0.0;

    return SystemPanel(
      title: 'Player Status',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // XP Bar Header
          Row(
            children: [
              const Icon(Icons.stars, color: SoloLevelingTheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'EXPERIENCE',
                style: SoloLevelingTheme.systemFont.copyWith(
                  fontSize: 12,
                  letterSpacing: 1,
                  color: SoloLevelingTheme.mutedForeground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          CustomProgressBar(
            progress: xpProgress,
            height: 12,
            segments: 10,
            showGlow: false, // New theme is flat
            fillColor: SoloLevelingTheme.primary,
            backgroundColor: SoloLevelingTheme.border,
          ),
          const SizedBox(height: 4),

          // XP Text
          Text(
            '${profile.currentXp} / ${profile.xpToNextLevel} XP',
            style: SoloLevelingTheme.systemFont.copyWith(
              fontSize: 12,
              color: SoloLevelingTheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Header
          Text(
            'STATS',
            style: SoloLevelingTheme.systemFont.copyWith(
              fontSize: 12,
              letterSpacing: 1,
              color: SoloLevelingTheme.mutedForeground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Stats Grid
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: profile.stats.entries.map((entry) {
              return _StatItem(
                name: entry.key,
                value: entry.value,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String name;
  final int value;

  const _StatItem({
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: SoloLevelingTheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: SoloLevelingTheme.border,
        ),
      ),
      child: Column(
        children: [
          Text(
            name.toUpperCase(),
            style: SoloLevelingTheme.systemFont.copyWith(
              fontSize: 10,
              letterSpacing: 1,
              color: SoloLevelingTheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '$value',
            style: SoloLevelingTheme.systemFont.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: SoloLevelingTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}