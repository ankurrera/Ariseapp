import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/dashboard/system_header.dart';
import '../../widgets/dashboard/player_status_panel.dart';
import '../../widgets/dashboard/radar_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background Effect
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.8),
                  radius: 1.5,
                  colors: [
                    Color(0xFF252525),
                    SoloLevelingTheme.background,
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: userProfileAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: SoloLevelingTheme.primary),
              ),
              error: (err, stack) => Center(child: Text('Error loading profile: $err')),
              data: (profile) {
                if (profile == null) return const Center(child: Text('No Profile Found'));

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      const SystemHeader(),
                      const SizedBox(height: 24),

                      // Workout Action Button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.fitness_center),
                          label: const Text('INITIATE WORKOUT'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SoloLevelingTheme.surface,
                            foregroundColor: SoloLevelingTheme.primary,
                            elevation: 0,
                            side: const BorderSide(color: SoloLevelingTheme.border),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            textStyle: SoloLevelingTheme.systemFont.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Panels
                      // FIXED: Passed the required 'profile' argument here
                      PlayerStatusPanel(profile: profile),
                      const SizedBox(height: 16),

                      const RadarChart(),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),

          // Top Right Actions
          Positioned(
            top: 40,
            right: 16,
            child: Row(
              children: [
                _HeaderActionButton(
                  icon: Icons.fitness_center,
                  onTap: () => context.push('/routines'),
                ),
                const SizedBox(width: 8),
                _HeaderActionButton(
                  icon: Icons.settings,
                  onTap: () => context.push('/profile'),
                ),
                const SizedBox(width: 8),
                _HeaderActionButton(
                  icon: Icons.logout,
                  onTap: () => ref.read(authNotifierProvider.notifier).signOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
        ),
        child: Icon(icon, color: SoloLevelingTheme.mutedForeground, size: 24),
      ),
    );
  }
}