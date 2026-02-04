import 'package:flutter/material.dart';
import '../../widgets/common/glow_text.dart';
import '../../widgets/common/system_panel.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GlowText(text: 'SKILLS', fontSize: 24),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Characteristics Panel (30%)
            const Expanded(
              flex: 3,
              child: SystemPanel(
                title: 'Characteristics',
                child: Text('Characteristics panel coming soon'),
              ),
            ),
            const SizedBox(width: 16),
            // Skills Grid (70%)
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  const SystemPanel(
                    title: 'Skills',
                    child: Text('Skills grid with progress bars coming soon'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Quick create skill
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('QUICK CREATE'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
