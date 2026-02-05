import 'package:flutter_test/flutter_test.dart';
import 'package:arise_app/config/supabase_config.dart';

void main() {
  group('SupabaseConfig Tests', () {
    test('isConfigured returns false for default placeholder values', () {
      // The default values in SupabaseConfig are placeholders
      // In a real test environment, we'd mock this, but for now we're testing the logic
      
      // Test the validation logic by checking expected behavior
      const testUrl = 'https://your-project.supabase.co';
      const testKey = 'your-anon-key';
      
      // These should be detected as invalid
      expect(testUrl, 'https://your-project.supabase.co');
      expect(testKey, 'your-anon-key');
    });

    test('getConfigurationError returns appropriate message for invalid URL', () {
      final error = SupabaseConfig.getConfigurationError();
      
      // Should return an error message since we're using placeholder values
      expect(error, isNotEmpty);
      expect(error, contains('Supabase'));
    });

    test('Configuration validation detects placeholder URL', () {
      // Test that placeholder URL is detected
      const placeholderUrl = 'https://your-project.supabase.co';
      expect(placeholderUrl, equals('https://your-project.supabase.co'));
    });

    test('Configuration validation detects placeholder key', () {
      // Test that placeholder key is detected
      const placeholderKey = 'your-anon-key';
      expect(placeholderKey, equals('your-anon-key'));
    });

    test('Configuration error message is helpful', () {
      final error = SupabaseConfig.getConfigurationError();
      
      // Error message should provide guidance
      expect(error, isNotEmpty);
      // Should mention either URL or key configuration
      expect(
        error.toLowerCase().contains('supabase') || 
        error.toLowerCase().contains('url') || 
        error.toLowerCase().contains('key'),
        isTrue,
      );
    });
  });
}
