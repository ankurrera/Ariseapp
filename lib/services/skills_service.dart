import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/skill.dart';

class SkillsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Skill>> getUserSkills(String userId) async {
    final response = await _supabase
        .from('skills')
        .select()
        .eq('user_id', userId)
        .order('category', ascending: true);

    return (response as List).map((json) => Skill.fromJson(json)).toList();
  }

  Future<Skill> createSkill(Skill skill) async {
    final response = await _supabase
        .from('skills')
        .insert(skill.toJson())
        .select()
        .single();

    return Skill.fromJson(response);
  }

  Future<Skill> updateSkill(Skill skill) async {
    final updatedSkill = skill.copyWith(updatedAt: DateTime.now());
    
    final response = await _supabase
        .from('skills')
        .update(updatedSkill.toJson())
        .eq('id', skill.id)
        .select()
        .single();

    return Skill.fromJson(response);
  }

  Future<void> deleteSkill(String skillId) async {
    await _supabase.from('skills').delete().eq('id', skillId);
  }

  Future<Skill> addProgress(String skillId, int progressAmount) async {
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

    return Skill.fromJson(response);
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
