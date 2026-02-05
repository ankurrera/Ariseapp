import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;

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
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration');
        debugPrint('   Make sure SUPABASE_URL and SUPABASE_ANON_KEY are set correctly');
      }
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
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration');
        debugPrint('   Make sure SUPABASE_URL and SUPABASE_ANON_KEY are set correctly');
      }
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
      debugPrint('ℹ️ No current user, cannot get profile');
      return null;
    }

    try {
      debugPrint('📋 Fetching user profile for: ${user.id}');
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      // If profile doesn't exist, create one
      if (response == null) {
        debugPrint('ℹ️ Profile not found, creating new profile');
        if (user.email == null || user.email!.isEmpty) {
          throw Exception('User email is required to create a profile');
        }
        return await createUserProfile(
          userId: user.id,
          email: user.email!,
        );
      }

      debugPrint('✓ Profile fetched successfully');
      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to get user profile: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration and database setup');
        debugPrint('   Ensure the profiles table exists in your Supabase project');
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
      debugPrint('📝 Creating user profile for: $email');
      final now = DateTime.now();
      final profile = UserProfile(
        id: userId,
        email: email,
        displayName: displayName,
        createdAt: now,
        updatedAt: now,
      );

      await _supabase.from('profiles').insert(profile.toJson());
      debugPrint('✓ Profile created successfully');

      return profile;
    } catch (e) {
      debugPrint('✗ Failed to create user profile: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration and database setup');
        debugPrint('   Ensure the profiles table exists with correct schema');
      }
      rethrow;
    }
  }

  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    try {
      debugPrint('📝 Updating user profile for: ${profile.id}');
      final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
      
      await _supabase
          .from('profiles')
          .update(updatedProfile.toJson())
          .eq('id', profile.id);

      debugPrint('✓ Profile updated successfully');
      return updatedProfile;
    } catch (e) {
      debugPrint('✗ Failed to update user profile: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check request payload and database schema');
      }
      rethrow;
    }
  }
}
