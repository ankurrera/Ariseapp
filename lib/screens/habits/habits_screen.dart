import 'package:flutter/material.dart';
import '../../widgets/common/glow_text.dart';
import '../../widgets/common/system_panel.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GlowText(text: 'HABITS', fontSize: 24),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SystemPanel(
              title: 'Daily Quests',
              child: Text('Habit tracker with heatmap coming soon'),
            ),
            SizedBox(height: 16),
            SystemPanel(
              title: 'Quest Cards',
              child: Text('Gamified goals coming soon'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open create habit dialog
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
