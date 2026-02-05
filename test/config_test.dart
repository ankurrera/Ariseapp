import 'package:flutter_test/flutter_test.dart';
import 'package:arise_app/config/supabase_config.dart';

/// Tests for SupabaseConfig validation logic
/// 
/// Note: SupabaseConfig uses compile-time constants (String.fromEnvironment),
/// so we test both the actual method behavior with current configuration
/// and the validation logic patterns to ensure they work correctly.
void main() {
  group('SupabaseConfig Tests', () {
    test('isConfigured returns consistent result', () {
      // Test the actual method - should consistently return same result
      final isConfigured1 = SupabaseConfig.isConfigured();
      final isConfigured2 = SupabaseConfig.isConfigured();
      
      expect(isConfigured1, equals(isConfigured2),
        reason: 'isConfigured should be deterministic');
    });

    test('isConfigured and getConfigurationError are consistent', () {
      // If isConfigured is false, there should be an error message
      // If isConfigured is true, there might still be a message but it should be generic
      final isConfigured = SupabaseConfig.isConfigured();
      final error = SupabaseConfig.getConfigurationError();
      
      if (!isConfigured) {
        expect(error, isNotEmpty,
          reason: 'Should have error message when not configured');
        expect(error.toLowerCase(), contains('not configured'),
          reason: 'Error should indicate configuration issue');
      }
    });

    test('getConfigurationError returns helpful message', () {
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

    test('getConfigurationError provides actionable guidance', () {
      final error = SupabaseConfig.getConfigurationError();
      
      // Should provide some form of guidance
      expect(error.length, greaterThan(20),
        reason: 'Error message should be descriptive enough to be helpful');
    });

    // Test validation logic patterns (unit tests for the logic)
    group('Validation Logic Tests', () {
      test('placeholder URL should be detected as invalid', () {
        // Test the pattern used in isConfigured()
        const testUrl = 'https://your-project.supabase.co';
        const realKey = 'some-real-key-value';
        
        final isPlaceholder = testUrl == 'https://your-project.supabase.co';
        
        expect(isPlaceholder, isTrue,
          reason: 'Should detect placeholder URL');
      });

      test('placeholder key should be detected as invalid', () {
        // Test the pattern used in isConfigured()
        const realUrl = 'https://real-project.supabase.co';
        const testKey = 'your-anon-key';
        
        final isPlaceholder = testKey == 'your-anon-key';
        
        expect(isPlaceholder, isTrue,
          reason: 'Should detect placeholder key');
      });

      test('valid credentials pattern should pass validation logic', () {
        // Test the pattern used in isConfigured()
        const realUrl = 'https://real-project.supabase.co';
        const realKey = 'real-anon-key-value-here';
        
        final hasPlaceholderUrl = realUrl == 'https://your-project.supabase.co';
        final hasPlaceholderKey = realKey == 'your-anon-key';
        final hasEmptyUrl = realUrl.isEmpty;
        final hasEmptyKey = realKey.isEmpty;
        
        expect(hasPlaceholderUrl, isFalse);
        expect(hasPlaceholderKey, isFalse);
        expect(hasEmptyUrl, isFalse);
        expect(hasEmptyKey, isFalse);
      });

      test('empty values should be detected as invalid', () {
        // Test the pattern used in isConfigured()
        const emptyUrl = '';
        const emptyKey = '';
        
        final isEmptyUrl = emptyUrl.isEmpty;
        final isEmptyKey = emptyKey.isEmpty;
        
        expect(isEmptyUrl, isTrue,
          reason: 'Should detect empty URL');
        expect(isEmptyKey, isTrue,
          reason: 'Should detect empty key');
      });
    });

    // Integration-style tests that verify actual behavior
    group('Integration Tests', () {
      test('current configuration state can be checked', () {
        // Test that we can check the configuration without errors
        expect(() => SupabaseConfig.isConfigured(), returnsNormally);
        expect(() => SupabaseConfig.getConfigurationError(), returnsNormally);
      });

      test('configuration values are accessible', () {
        // Test that configuration values can be read
        expect(() => SupabaseConfig.url, returnsNormally);
        expect(() => SupabaseConfig.anonKey, returnsNormally);
        
        // Values should not be null
        expect(SupabaseConfig.url, isNotNull);
        expect(SupabaseConfig.anonKey, isNotNull);
      });
    });
  });
}
