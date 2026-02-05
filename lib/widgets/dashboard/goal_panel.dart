import 'package:flutter/material.dart';
import '../common/system_panel.dart';

class GoalPanel extends StatelessWidget {
  const GoalPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return const SystemPanel(title: "Goals", child: SizedBox(height: 100, child: Center(child: Text("Goals"))));
  }
}