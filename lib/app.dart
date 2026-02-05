import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes.dart';
import 'config/theme.dart';

class AriseApp extends ConsumerWidget {
  const AriseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Arise',
      debugShowCheckedModeBanner: false,

      // Set default theme to LIGHT to match the white pictures
      theme: SoloLevelingTheme.lightTheme,
      themeMode: ThemeMode.light, // Forces light mode

      routerConfig: router,
    );
  }
}