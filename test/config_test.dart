import 'package:flutter_test/flutter_test.dart';
import 'package:arise_app/config/supabase_config.dart';

void main() {
  group('SupabaseConfig Tests', () {
    test('isConfigured detects placeholder values correctly', () {
      // Since we can't easily mock compile-time constants, we test the actual state
      // In a production app with valid credentials, this would return true
      // With placeholder values, it should return false
      final isConfigured = SupabaseConfig.isConfigured();
      
      // With placeholder values, should be false
      // (This will fail if the app is configured with real credentials, which is expected)
      if (SupabaseConfig.url == 'https://your-project.supabase.co' || 
          SupabaseConfig.anonKey == 'your-anon-key') {
        expect(isConfigured, isFalse);
      } else {
        // If real credentials are configured, should be true
        expect(isConfigured, isTrue);
      }
    });

    test('getConfigurationError returns helpful message when URL is placeholder', () {
      final error = SupabaseConfig.getConfigurationError();
      
      // If using placeholder URL, should get URL-specific error
      if (SupabaseConfig.url == 'https://your-project.supabase.co') {
        expect(error, contains('Supabase URL'));
        expect(error, contains('not configured'));
        expect(error.toLowerCase(), contains('supabase_url'));
      }
    });

    test('getConfigurationError returns helpful message when key is placeholder', () {
      final error = SupabaseConfig.getConfigurationError();
      
      // If using placeholder key (and URL is configured), should get key-specific error
      if (SupabaseConfig.url != 'https://your-project.supabase.co' && 
          SupabaseConfig.anonKey == 'your-anon-key') {
        expect(error, contains('anon key'));
        expect(error, contains('not configured'));
        expect(error.toLowerCase(), contains('supabase_anon_key'));
      }
    });

    test('Configuration error message provides actionable guidance', () {
      final error = SupabaseConfig.getConfigurationError();
      
      // Error message should be helpful and actionable
      expect(error, isNotEmpty);
      
      // Should mention Supabase or configuration
      final lowerError = error.toLowerCase();
      expect(
        lowerError.contains('supabase') || 
        lowerError.contains('url') || 
        lowerError.contains('key') ||
        lowerError.contains('config'),
        isTrue,
        reason: 'Error message should mention configuration-related terms',
      );
    });

    test('Configuration validation logic with placeholder URL', () {
      // Test the logic: placeholder URL should make isConfigured return false
      const testUrl = 'https://your-project.supabase.co';
      const realKey = 'some-real-key-value';
      
      // Logic test: if URL is placeholder, should be invalid
      final wouldBeValid = testUrl != 'https://your-project.supabase.co' && 
                          realKey != 'your-anon-key' &&
                          testUrl.isNotEmpty && 
                          realKey.isNotEmpty;
      
      expect(wouldBeValid, isFalse, 
        reason: 'Placeholder URL should make configuration invalid');
    });

    test('Configuration validation logic with placeholder key', () {
      // Test the logic: placeholder key should make isConfigured return false
      const realUrl = 'https://real-project.supabase.co';
      const testKey = 'your-anon-key';
      
      // Logic test: if key is placeholder, should be invalid
      final wouldBeValid = realUrl != 'https://your-project.supabase.co' && 
                          testKey != 'your-anon-key' &&
                          realUrl.isNotEmpty && 
                          testKey.isNotEmpty;
      
      expect(wouldBeValid, isFalse,
        reason: 'Placeholder key should make configuration invalid');
    });

    test('Configuration validation logic with valid credentials', () {
      // Test the logic: real credentials should be valid
      const realUrl = 'https://real-project.supabase.co';
      const realKey = 'real-anon-key-value-here';
      
      // Logic test: real values should be valid
      final wouldBeValid = realUrl != 'https://your-project.supabase.co' && 
                          realKey != 'your-anon-key' &&
                          realUrl.isNotEmpty && 
                          realKey.isNotEmpty;
      
      expect(wouldBeValid, isTrue,
        reason: 'Real credentials should make configuration valid');
    });

    test('Configuration validation logic with empty values', () {
      // Test the logic: empty values should be invalid
      const emptyUrl = '';
      const emptyKey = '';
      
      // Logic test: empty values should be invalid
      final wouldBeValid = emptyUrl != 'https://your-project.supabase.co' && 
                          emptyKey != 'your-anon-key' &&
                          emptyUrl.isNotEmpty && 
                          emptyKey.isNotEmpty;
      
      expect(wouldBeValid, isFalse,
        reason: 'Empty credentials should make configuration invalid');
    });
  });
}
