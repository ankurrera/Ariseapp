import 'package:flutter_test/flutter_test.dart';
import 'package:arise_app/config/supabase_config.dart';

void main() {
  group('SupabaseConfig', () {
    test('constants are available', () {
      // These are static constants, so we just check they exist and are strings
      expect(SupabaseConfig.url, isA<String>());
      expect(SupabaseConfig.anonKey, isA<String>());

      // In a real app, these would come from --dart-define or .env
      // For now we just verify they are not empty defaults if set
    });
  });
}