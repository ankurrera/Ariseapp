import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/glow_text.dart';
import '../../widgets/common/system_panel.dart';
import '../../widgets/dashboard/player_status_panel.dart';
import '../../widgets/dashboard/system_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const GlowText(text: 'ARISE', fontSize: 24),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authNotifierProvider.notifier).signOut();
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: userProfile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('No profile found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SystemHeader(profile: profile),
                const SizedBox(height: 16),
                PlayerStatusPanel(profile: profile),
                const SizedBox(height: 16),
                
                // Grid layout for other panels
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;
                    
                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                _buildSkillPointsPanel(),
                                const SizedBox(height: 16),
                                _buildGoalPanel(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                _buildCalendarPanel(),
                                const SizedBox(height: 16),
                                _buildPotionsPanel(),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildSkillPointsPanel(),
                          const SizedBox(height: 16),
                          _buildCalendarPanel(),
                          const SizedBox(height: 16),
                          _buildGoalPanel(),
                          const SizedBox(height: 16),
                          _buildPotionsPanel(),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                _buildSessionHistory(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: SoloLevelingTheme.darkPanel,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: SoloLevelingTheme.primaryGradient,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GlowText(text: 'ARISE', fontSize: 32),
                SizedBox(height: 8),
                Text('Solo Leveling System'),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => context.go('/'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.fitness_center,
            title: 'Routines',
            onTap: () => context.push('/routines'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.task_alt,
            title: 'Habits',
            onTap: () => context.push('/habits'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.stars,
            title: 'Skills',
            onTap: () => context.push('/skills'),
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'Profile',
            onTap: () => context.push('/profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: SoloLevelingTheme.glowBlue),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Widget _buildSkillPointsPanel() {
    return const SystemPanel(
      title: 'Skill Points',
      child: Column(
        children: [
          Icon(Icons.stars, size: 48, color: SoloLevelingTheme.glowBlue),
          SizedBox(height: 16),
          Text(
            '5',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text('Available Points'),
        ],
      ),
    );
  }

  Widget _buildCalendarPanel() {
    return const SystemPanel(
      title: 'Training Calendar',
      child: Center(
        child: Text('Calendar view coming soon'),
      ),
    );
  }

  Widget _buildGoalPanel() {
    return const SystemPanel(
      title: 'Current Goals',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• Complete 5 workouts this week'),
          SizedBox(height: 8),
          Text('• Maintain habit streak'),
          SizedBox(height: 8),
          Text('• Level up to 10'),
        ],
      ),
    );
  }

  Widget _buildPotionsPanel() {
    return const SystemPanel(
      title: 'Potions & Items',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _PotionItem(name: 'Health', count: 3),
          _PotionItem(name: 'Mana', count: 5),
          _PotionItem(name: 'XP Boost', count: 1),
        ],
      ),
    );
  }

  Widget _buildSessionHistory() {
    return const SystemPanel(
      title: 'Recent Sessions',
      child: Column(
        children: [
          _SessionItem(title: 'Upper Body Workout', xp: 50, date: '2 days ago'),
          SizedBox(height: 8),
          _SessionItem(title: 'Cardio Session', xp: 30, date: '3 days ago'),
          SizedBox(height: 8),
          _SessionItem(title: 'Leg Day', xp: 60, date: '5 days ago'),
        ],
      ),
    );
  }
}

class _PotionItem extends StatelessWidget {
  final String name;
  final int count;

  const _PotionItem({required this.name, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SoloLevelingTheme.darkPanelBorder,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.local_drink, size: 32),
        ),
        const SizedBox(height: 8),
        Text(name),
        Text('x$count', style: const TextStyle(color: SoloLevelingTheme.glowBlue)),
      ],
    );
  }
}

class _SessionItem extends StatelessWidget {
  final String title;
  final int xp;
  final String date;

  const _SessionItem({
    required this.title,
    required this.xp,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: SoloLevelingTheme.darkPanelBorder.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(date, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: SoloLevelingTheme.primaryBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('+$xp XP', style: const TextStyle(color: SoloLevelingTheme.glowBlue)),
          ),
        ],
      ),
    );
  }
}
