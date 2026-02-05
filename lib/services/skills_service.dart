import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/skill.dart';

class SkillsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Skill>> getUserSkills(String userId) async {
    try {
      debugPrint('📋 Fetching skills for user: $userId');
      final response = await _supabase
          .from('skills')
          .select()
          .eq('user_id', userId)
          .order('category', ascending: true);

      final skills = (response as List).map((json) => Skill.fromJson(json)).toList();
      debugPrint('✓ Fetched ${skills.length} skills successfully');
      return skills;
    } catch (e) {
      debugPrint('✗ Failed to fetch skills: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration and database setup');
        debugPrint('   Ensure the skills table exists in your Supabase project');
      }
      rethrow;
    }
  }

  Future<Skill> createSkill(Skill skill) async {
    try {
      debugPrint('📝 Creating new skill: ${skill.name}');
      final response = await _supabase
          .from('skills')
          .insert(skill.toJson())
          .select()
          .single();

      debugPrint('✓ Skill created successfully');
      return Skill.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to create skill: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check skill data format');
        debugPrint('   Skill data: ${skill.toJson()}');
      }
      rethrow;
    }
  }

  Future<Skill> updateSkill(Skill skill) async {
    try {
      debugPrint('📝 Updating skill: ${skill.id}');
      final updatedSkill = skill.copyWith(updatedAt: DateTime.now());
      
      final response = await _supabase
          .from('skills')
          .update(updatedSkill.toJson())
          .eq('id', skill.id)
          .select()
          .single();

      debugPrint('✓ Skill updated successfully');
      return Skill.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to update skill: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check skill data format');
      }
      rethrow;
    }
  }

  Future<void> deleteSkill(String skillId) async {
    try {
      debugPrint('🗑️ Deleting skill: $skillId');
      await _supabase.from('skills').delete().eq('id', skillId);
      debugPrint('✓ Skill deleted successfully');
    } catch (e) {
      debugPrint('✗ Failed to delete skill: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check skill ID');
      }
      rethrow;
    }
  }

  Future<Skill> addProgress(String skillId, int progressAmount) async {
    try {
      debugPrint('⭐ Adding $progressAmount progress to skill: $skillId');
      // Get the skill
      final skillData = await _supabase
          .from('skills')
          .select()
          .eq('id', skillId)
          .single();

      final skill = Skill.fromJson(skillData);

      // Calculate new progress
      int newProgress = skill.currentProgress + progressAmount;
      int newLevel = skill.level;

      // Check if leveled up
      while (newProgress >= skill.maxProgress) {
        newProgress -= skill.maxProgress;
        newLevel++;
        debugPrint('🎉 Skill level up! New level: $newLevel');
      }

      final updatedSkill = skill.copyWith(
        level: newLevel,
        currentProgress: newProgress,
        updatedAt: DateTime.now(),
      );

      // Save to database
      final response = await _supabase
          .from('skills')
          .update(updatedSkill.toJson())
          .eq('id', skillId)
          .select()
          .single();

      debugPrint('✓ Progress added successfully. New level: $newLevel, progress: $newProgress/${skill.maxProgress}');
      return Skill.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to add progress: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check skill ID and progress amount');
      }
      rethrow;
    }
  }

  /// Get skills grouped by category
  Map<String, List<Skill>> groupByCategory(List<Skill> skills) {
    final Map<String, List<Skill>> grouped = {};
    
    for (final skill in skills) {
      if (!grouped.containsKey(skill.category)) {
        grouped[skill.category] = [];
      }
      grouped[skill.category]!.add(skill);
    }
    
    return grouped;
  }

  /// Calculate progress percentage for a skill
  double getProgressPercentage(Skill skill) {
    return skill.currentProgress / skill.maxProgress;
  }
}
