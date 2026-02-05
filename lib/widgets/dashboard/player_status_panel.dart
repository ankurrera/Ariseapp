import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/user_profile.dart';

class PlayerStatusPanel extends StatelessWidget {
  final UserProfile profile;

  const PlayerStatusPanel({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    // Access current theme colors
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Logic
    const int xpForNextLevel = 1000;
    final double xpProgress = (profile.currentXp / xpForNextLevel).clamp(0.0, 1.0);
    const int coins = 225;

    // Stats
    final stats = profile.stats.isEmpty ? {
      'strength': 30,
      'endurance': 25,
      'recovery': 50,
      'health': 100,
    } : profile.stats;

    final int healthPercent = stats['health'] ?? 100;
    final int filledHearts = ((healthPercent / 100) * 5).round();

    return Card(
      // Card style comes from Theme (lightCard + lightBorder)
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: SoloLevelingTheme.lightAccent, // Light grey background for pill
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 12, color: colorScheme.onSurface.withOpacity(0.6)),
                  const SizedBox(width: 6),
                  Text(
                      "Profile",
                      style: SoloLevelingTheme.systemFont.copyWith(
                          fontSize: 12,
                          color: colorScheme.onSurface.withOpacity(0.6)
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Hero Image Area (Gradient)
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // Gradient colors for Hero card background (Subtle grey to slightly darker grey)
                  colors: [
                    Color(0xFFF5F5F5), // Very light grey
                    Color(0xFFE0E0E0), // Slightly darker
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Icon(Icons.shield, size: 48, color: colorScheme.onSurface.withOpacity(0.2)),
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
                Text("Level Up", style: textTheme.bodyMedium),
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
                // Colors for Light Theme
                backgroundColor: SoloLevelingTheme.lightBorder,
                color: colorScheme.primary, // Dark Grey/Black
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${profile.currentXp} / $xpForNextLevel",
              style: textTheme.labelSmall,
            ),
            const SizedBox(height: 24),

            // 6. Health Section
            Row(
              children: [
                Text("Health", style: textTheme.bodyMedium),
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
                    // Filled hearts match primary color (Dark Grey/Black), empty are transparent grey
                    color: index < filledHearts
                        ? colorScheme.primary
                        : colorScheme.onSurface.withOpacity(0.2),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "$healthPercent%",
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
        Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)
        ),
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
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelSmall),
        const SizedBox(height: 2),
        Text(value, style: textTheme.bodyLarge),
      ],
    );
  }
}