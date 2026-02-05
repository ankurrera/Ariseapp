import 'package:flutter/material.dart';
import '../common/system_panel.dart';

class CalendarPanel extends StatelessWidget {
  const CalendarPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return const SystemPanel(title: "Calendar", child: SizedBox(height: 100, child: Center(child: Text("Calendar"))));
  }
}