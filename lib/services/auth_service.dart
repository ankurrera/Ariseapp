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
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<UserProfile?> getUserProfile() async {
    final user = currentUser;
    if (user == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    // If profile doesn't exist, create one
    if (response == null) {
      return await createUserProfile(
        userId: user.id,
        email: user.email ?? '',
      );
    }

    return UserProfile.fromJson(response);
  }

  Future<UserProfile> createUserProfile({
    required String userId,
    required String email,
    String? displayName,
  }) async {
    final now = DateTime.now();
    final profile = UserProfile(
      id: userId,
      email: email,
      displayName: displayName,
      createdAt: now,
      updatedAt: now,
    );

    await _supabase.from('profiles').insert(profile.toJson());

    return profile;
  }

  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
    
    await _supabase
        .from('profiles')
        .update(updatedProfile.toJson())
        .eq('id', profile.id);

    return updatedProfile;
  }
}
