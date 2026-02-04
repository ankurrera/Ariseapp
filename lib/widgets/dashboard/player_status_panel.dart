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
    final xpProgress = profile.currentXp / profile.xpToNextLevel;

    return SystemPanel(
      title: 'Player Status',
      showGlow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // XP Bar
          Row(
            children: [
              const Icon(Icons.stars, color: SoloLevelingTheme.glowBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                'EXPERIENCE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomProgressBar(
            progress: xpProgress,
            height: 12,
            segments: 10,
          ),
          const SizedBox(height: 4),
          Text(
            '${profile.currentXp} / ${profile.xpToNextLevel} XP',
            style: const TextStyle(fontSize: 12, color: SoloLevelingTheme.textSecondary),
          ),
          const SizedBox(height: 24),
          
          // Stats Grid
          Text(
            'STATS',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 12),
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
        color: SoloLevelingTheme.darkPanelBorder.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: SoloLevelingTheme.glowBlue.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            name.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              color: SoloLevelingTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: SoloLevelingTheme.glowBlue,
            ),
          ),
        ],
      ),
    );
  }
}
