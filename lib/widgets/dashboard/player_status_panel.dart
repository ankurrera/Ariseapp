import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/user_profile.dart';

class PlayerStatusPanel extends StatelessWidget {
  final UserProfile profile;

  const PlayerStatusPanel({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    // Logic from React
    const int xpForNextLevel = 1000;
    final double xpProgress = (profile.currentXp / xpForNextLevel).clamp(0.0, 1.0);
    const int coins = 225; // Placeholder

    // Stats Defaults (Matching React fallback)
    final stats = profile.stats.isEmpty ? {
      'strength': 30,
      'endurance': 25,
      'recovery': 50,
      'health': 100,
    } : profile.stats;

    final int healthPercent = stats['health'] ?? 100;
    final int filledHearts = ((healthPercent / 100) * 5).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: SoloLevelingTheme.muted,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person, size: 12, color: SoloLevelingTheme.mutedForeground),
                  const SizedBox(width: 6),
                  Text("Profile", style: SoloLevelingTheme.systemFont.copyWith(fontSize: 12, color: SoloLevelingTheme.mutedForeground)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Hero Image Area
            Container(
              height: 100, // Aspect Ratio approx 2/1 relative to width
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [SoloLevelingTheme.muted, SoloLevelingTheme.accent],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: const Center(
                child: Icon(Icons.shield, size: 48, color: Colors.white12),
              ),
            ),
            const SizedBox(height: 24),

            // 3. Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoItem(label: profile.displayName ?? "Hero", icon: "🐱"),
                _InfoItem(label: "Level ${profile.level}", icon: "📈"),
                const _InfoItem(label: "$coins Coins", icon: "💰"),
              ],
            ),
            const SizedBox(height: 24),

            // 4. Stats Vertical Stack
            _StatRow(label: "Experience", value: "Experience (XP): ⚒️ ${profile.currentXp}"),
            const SizedBox(height: 12),
            _StatRow(label: "Next Level", value: "To Next Level 💗: ${xpForNextLevel - profile.currentXp}"),
            const SizedBox(height: 24),

            // 5. Progress Bar
            Row(
              children: [
                Text("Level Up", style: SoloLevelingTheme.systemFont.copyWith(fontSize: 14, color: SoloLevelingTheme.mutedForeground)),
                const SizedBox(width: 8),
                const Text("🚀", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: xpProgress,
                minHeight: 8,
                backgroundColor: SoloLevelingTheme.border,
                color: SoloLevelingTheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${profile.currentXp} / $xpForNextLevel",
              style: SoloLevelingTheme.systemFont.copyWith(fontSize: 12, color: SoloLevelingTheme.mutedForeground),
            ),
            const SizedBox(height: 24),

            // 6. Health Section
            Row(
              children: [
                Text("Health", style: SoloLevelingTheme.systemFont.copyWith(fontSize: 14, color: SoloLevelingTheme.mutedForeground)),
                const SizedBox(width: 8),
                const Text("❤️", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                ...List.generate(5, (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: index < filledHearts
                        ? SoloLevelingTheme.primary
                        : SoloLevelingTheme.mutedForeground.withOpacity(0.3),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 4),
            // FIXED: Used Theme.of(context) instead of SoloLevelingTheme.bodyLarge
            Text(
              "$healthPercent%",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String icon;
  const _InfoItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: SoloLevelingTheme.systemFont.copyWith(fontWeight: FontWeight.w500, color: SoloLevelingTheme.primary)),
        const SizedBox(width: 4),
        Text(icon, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: SoloLevelingTheme.systemFont.copyWith(fontSize: 12, color: SoloLevelingTheme.mutedForeground)),
        const SizedBox(height: 2),
        Text(value, style: SoloLevelingTheme.systemFont.copyWith(fontSize: 14, color: SoloLevelingTheme.primary)),
      ],
    );
  }
}