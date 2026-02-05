import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;
  Session? get currentSession => _supabase.auth.currentSession;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔐 Attempting sign up for: $email');
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      debugPrint('✓ Sign up successful for: $email');
      return response;
    } catch (e) {
      debugPrint('✗ Sign up failed: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('🔐 Attempting sign in for: $email');
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      debugPrint('✓ Sign in successful for: $email');
      return response;
    } catch (e) {
      debugPrint('✗ Sign in failed: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint('🔐 Attempting sign out');
      await _supabase.auth.signOut();
      debugPrint('✓ Sign out successful');
    } catch (e) {
      debugPrint('✗ Sign out failed: $e');
      rethrow;
    }
  }

  Future<UserProfile?> getUserProfile() async {
    final user = currentUser;
    if (user == null) {
      return null;
    }

    try {
      // FIXED: Query by 'user_id' instead of 'id' to find profiles created by the Web App
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      if (response == null) {
        if (user.email == null) {
          throw Exception('User email is required');
        }
        return await createUserProfile(
          userId: user.id,
          email: user.email!,
        );
      }

      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to get user profile: $e');
      // If we caught the duplicate error here during a race condition, try fetching again
      if (e.toString().contains('23505')) {
        final retryResponse = await _supabase
            .from('profiles')
            .select()
            .eq('user_id', user.id)
            .maybeSingle();
        if (retryResponse != null) {
          return UserProfile.fromJson(retryResponse);
        }
      }
      rethrow;
    }
  }

  Future<UserProfile> createUserProfile({
    required String userId,
    required String email,
    String? displayName,
  }) async {
    try {
      final now = DateTime.now();
      final profile = UserProfile(
        id: userId,
        email: email,
        displayName: displayName,
        createdAt: now,
        updatedAt: now,
      );

      // We don't need the return value of insert since we have the object
      await _supabase.from('profiles').insert(profile.toJson());
      return profile;
    } catch (e) {
      // If profile was created by a trigger or another client concurrently
      if (e.toString().contains('23505')) {
        debugPrint('⚠️ Profile already exists (duplicate key), fetching existing...');
        final existing = await _supabase
            .from('profiles')
            .select()
            .eq('user_id', userId)
            .single();
        return UserProfile.fromJson(existing);
      }
      debugPrint('✗ Failed to create user profile: $e');
      rethrow;
    }
  }
}