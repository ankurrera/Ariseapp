import 'package:flutter/material.dart';
import '../../widgets/common/glow_text.dart';
import '../../widgets/common/system_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GlowText(text: 'PROFILE', fontSize: 24),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SystemPanel(
              title: 'Player Class',
              child: Column(
                children: [
                  Text('Select your class:'),
                  SizedBox(height: 16),
                  Text('Warrior • Assassin • Mage'),
                ],
              ),
            ),
            SizedBox(height: 16),
            SystemPanel(
              title: 'Profile Settings',
              child: Text('Profile customization coming soon'),
            ),
          ],
        ),
      ),
    );
  }
}
