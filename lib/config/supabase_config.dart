class SupabaseConfig {
  // TODO: Replace with your actual Supabase project credentials
  // These should be stored in environment variables in production
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );
  
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key',
  );
  
  /// Validates that Supabase configuration is properly set up
  /// Returns true if valid, false otherwise
  static bool isConfigured() {
    return url != 'https://your-project.supabase.co' && 
           anonKey != 'your-anon-key' &&
           url.isNotEmpty && 
           anonKey.isNotEmpty;
  }
  
  /// Gets a detailed error message for configuration issues
  static String getConfigurationError() {
    if (url == 'https://your-project.supabase.co') {
      return 'Supabase URL is not configured. Please set SUPABASE_URL environment variable or update lib/config/supabase_config.dart';
    }
    if (anonKey == 'your-anon-key') {
      return 'Supabase anon key is not configured. Please set SUPABASE_ANON_KEY environment variable or update lib/config/supabase_config.dart';
    }
    if (url.isEmpty) {
      return 'Supabase URL is empty';
    }
    if (anonKey.isEmpty) {
      return 'Supabase anon key is empty';
    }
    return 'Supabase configuration is invalid';
  }
}
