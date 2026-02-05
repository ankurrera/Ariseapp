import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Validate Supabase configuration before initialization
  if (!SupabaseConfig.isConfigured()) {
    debugPrint('⚠️ WARNING: Supabase Configuration Error ⚠️');
    debugPrint('━' * 60);
    debugPrint(SupabaseConfig.getConfigurationError());
    debugPrint('━' * 60);
    debugPrint('To fix this issue:');
    debugPrint('1. Create a Supabase project at https://supabase.com');
    debugPrint('2. Get your project URL and anon key from project settings');
    debugPrint('3. Run the app with environment variables:');
    debugPrint('   flutter run --dart-define=SUPABASE_URL=your-url --dart-define=SUPABASE_ANON_KEY=your-key');
    debugPrint('   OR update lib/config/supabase_config.dart directly');
    debugPrint('━' * 60);
  }
  
  try {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
    debugPrint('✓ Supabase initialized successfully');
  } catch (e) {
    debugPrint('✗ Failed to initialize Supabase: $e');
    debugPrint('Please check your Supabase configuration');
  }
  
  runApp(
    const ProviderScope(
      child: AriseApp(),
    ),
  );
}
