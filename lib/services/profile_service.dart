import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<UserProfile?> getProfile(String userId) async {
    try {
      debugPrint('📋 Fetching profile for user: $userId');
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      debugPrint('✓ Profile fetched successfully');
      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to fetch profile: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration and database setup');
      }
      return null;
    }
  }

  Future<UserProfile> updateProfile(UserProfile profile) async {
    try {
      debugPrint('📝 Updating profile for user: ${profile.id}');
      final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
      
      final response = await _supabase
          .from('profiles')
          .update(updatedProfile.toJson())
          .eq('id', profile.id)
          .select()
          .single();

      debugPrint('✓ Profile updated successfully');
      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to update profile: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check request payload format');
        debugPrint('   Profile data: ${profile.toJson()}');
      }
      rethrow;
    }
  }

  Future<UserProfile> addXp(String userId, int xpAmount) async {
    try {
      debugPrint('⭐ Adding $xpAmount XP to user: $userId');
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
        debugPrint('🎉 Level up! New level: $newLevel');
      }

      // Update profile
      final updatedProfile = profile.copyWith(
        currentXp: newXp,
        level: newLevel,
        xpToNextLevel: xpToNext,
        updatedAt: DateTime.now(),
      );

      debugPrint('✓ XP added successfully. New level: $newLevel, XP: $newXp/$xpToNext');
      return await updateProfile(updatedProfile);
    } catch (e) {
      debugPrint('✗ Failed to add XP: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error during XP update');
      }
      rethrow;
    }
  }

  Future<UserProfile> allocateStatPoint(
    String userId,
    String statName,
  ) async {
    try {
      debugPrint('💪 Allocating stat point to $statName for user: $userId');
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

      debugPrint('✓ Stat point allocated successfully');
      return await updateProfile(updatedProfile);
    } catch (e) {
      debugPrint('✗ Failed to allocate stat point: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error during stat allocation');
      }
      rethrow;
    }
  }

  Future<UserProfile> changePlayerClass(
    String userId,
    String newClass,
  ) async {
    try {
      debugPrint('🎭 Changing player class to $newClass for user: $userId');
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

      debugPrint('✓ Player class changed successfully');
      return await updateProfile(updatedProfile);
    } catch (e) {
      debugPrint('✗ Failed to change player class: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error during class change');
      }
      rethrow;
    }
  }

  int _calculateXpForLevel(int level) {
    // Formula: 100 * level^1.5
    return (100 * math.pow(level, 1.5)).round();
  }
}
