import 'package:flutter/material.dart';
import '../../widgets/common/glow_text.dart';
import '../../widgets/common/system_panel.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GlowText(text: 'ROUTINES', fontSize: 24),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SystemPanel(
              title: 'Your Routines',
              child: Text('Workout routine management coming soon'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Create routine
        },
        icon: const Icon(Icons.add),
        label: const Text('NEW ROUTINE'),
      ),
    );
  }
}
