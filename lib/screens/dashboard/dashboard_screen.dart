import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/corner_decoration.dart';
import '../../widgets/dashboard/system_header.dart';
import '../../widgets/dashboard/player_status_panel.dart';
import '../../widgets/dashboard/radar_chart.dart';
import '../../widgets/dashboard/skill_points_panel.dart';
import '../../widgets/dashboard/calendar_panel.dart';
import '../../widgets/dashboard/goal_panel.dart';
import '../../widgets/dashboard/session_history.dart';
import '../../widgets/dashboard/potions_panel.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: SoloLevelingTheme.background,
      body: Stack(
        children: [
          // 1. Subtle Background Decoration (Top Gradient)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.0,
                  colors: [
                    // Very subtle warm tint for light mode
                    SoloLevelingTheme.primary.withOpacity(0.03),
                    SoloLevelingTheme.background,
                  ],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
          ),

          // 2. Corner Decorations
          const Positioned(top: 16, left: 16, child: CornerDecoration(corner: Corner.topLeft)),
          const Positioned(top: 16, right: 16, child: CornerDecoration(corner: Corner.topRight)),
          const Positioned(bottom: 16, left: 16, child: CornerDecoration(corner: Corner.bottomLeft)),
          const Positioned(bottom: 16, right: 16, child: CornerDecoration(corner: Corner.bottomRight)),

          // 3. Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  // Top Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _TopIconButton(icon: Icons.fitness_center, onTap: () => context.push('/routines')),
                      const SizedBox(width: 8),
                      _TopIconButton(icon: Icons.settings, onTap: () => context.push('/profile')),
                      const SizedBox(width: 8),
                      _TopIconButton(icon: Icons.logout, onTap: () => ref.read(authNotifierProvider.notifier).signOut()),
                    ],
                  ),

                  // Header
                  const SystemHeader(),
                  const SizedBox(height: 16),

                  // Workout Button
                  ElevatedButton(
                    onPressed: () {}, // TODO: Open Session Form
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SoloLevelingTheme.primary,
                      foregroundColor: SoloLevelingTheme.background,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: SoloLevelingTheme.systemFont.copyWith(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text("INITIATE WORKOUT"),
                  ),
                  const SizedBox(height: 32),

                  // Main Grid
                  userProfileAsync.when(
                    data: (profile) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (profile != null) PlayerStatusPanel(profile: profile),
                        const SizedBox(height: 16),
                        const RadarChart(),
                        const SizedBox(height: 16),
                        const SkillPointsPanel(),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(child: CalendarPanel()),
                            SizedBox(width: 16),
                            Expanded(child: GoalPanel()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const SessionHistory(),
                        const SizedBox(height: 16),
                        const PotionsPanel(),
                      ],
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text("Error: $e")),
                  ),

                  // Footer Decoration
                  const SizedBox(height: 32),
                  const _FooterDecoration(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 24, color: SoloLevelingTheme.mutedForeground),
      ),
    );
  }
}

class _FooterDecoration extends StatelessWidget {
  const _FooterDecoration();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96,
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
          transform: Matrix4.rotationZ(0.785398),
          decoration: BoxDecoration(
            border: Border.all(color: SoloLevelingTheme.primary.withOpacity(0.5)),
          ),
        ),
        Container(
          width: 96,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [SoloLevelingTheme.primary.withOpacity(0.5), Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }
}