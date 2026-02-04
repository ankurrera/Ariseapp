import 'dart:math' as math;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<UserProfile?> getProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return UserProfile.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<UserProfile> updateProfile(UserProfile profile) async {
    final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
    
    final response = await _supabase
        .from('profiles')
        .update(updatedProfile.toJson())
        .eq('id', profile.id)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  Future<UserProfile> addXp(String userId, int xpAmount) async {
    // Get current profile
    final profile = await getProfile(userId);
    if (profile == null) {
      throw Exception('Profile not found');
    }

    // Calculate new XP and level
    int newXp = profile.currentXp + xpAmount;
    int newLevel = profile.level;
    int xpToNext = profile.xpToNextLevel;

    // Check for level ups
    while (newXp >= xpToNext) {
      newXp -= xpToNext;
      newLevel++;
      xpToNext = _calculateXpForLevel(newLevel);
    }

    // Update profile
    final updatedProfile = profile.copyWith(
      currentXp: newXp,
      level: newLevel,
      xpToNextLevel: xpToNext,
      updatedAt: DateTime.now(),
    );

    return await updateProfile(updatedProfile);
  }

  Future<UserProfile> allocateStatPoint(
    String userId,
    String statName,
  ) async {
    // Get current profile
    final profile = await getProfile(userId);
    if (profile == null) {
      throw Exception('Profile not found');
    }

    // Check if user has skill points
    if (profile.skillPoints <= 0) {
      throw Exception('No skill points available');
    }

    // Update stat
    final updatedStats = Map<String, int>.from(profile.stats);
    updatedStats[statName] = (updatedStats[statName] ?? 0) + 1;

    // Update profile
    final updatedProfile = profile.copyWith(
      stats: updatedStats,
      skillPoints: profile.skillPoints - 1,
      updatedAt: DateTime.now(),
    );

    return await updateProfile(updatedProfile);
  }

  Future<UserProfile> changePlayerClass(
    String userId,
    String newClass,
  ) async {
    // Get current profile
    final profile = await getProfile(userId);
    if (profile == null) {
      throw Exception('Profile not found');
    }

    // Update class
    final updatedProfile = profile.copyWith(
      playerClass: newClass,
      updatedAt: DateTime.now(),
    );

    return await updateProfile(updatedProfile);
  }

  int _calculateXpForLevel(int level) {
    // Formula: 100 * level^1.5
    return (100 * math.pow(level, 1.5)).round();
  }
}
