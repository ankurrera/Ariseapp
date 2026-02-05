import 'package:flutter/material.dart';
import '../common/system_panel.dart';

class SessionHistory extends StatelessWidget {
  const SessionHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return const SystemPanel(title: "History", child: SizedBox(height: 100, child: Center(child: Text("Session History"))));
  }
}