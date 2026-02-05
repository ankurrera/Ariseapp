import 'package:flutter/material.dart';
import '../common/system_panel.dart';

class PotionsPanel extends StatelessWidget {
  const PotionsPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return const SystemPanel(title: "Potions", child: SizedBox(height: 100, child: Center(child: Text("Potions"))));
  }
}