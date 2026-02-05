import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/habit.dart';

class HabitsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Habit>> getUserHabits(String userId) async {
    try {
      debugPrint('📋 Fetching habits for user: $userId');
      final response = await _supabase
          .from('habits')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final habits = (response as List).map((json) => Habit.fromJson(json)).toList();
      debugPrint('✓ Fetched ${habits.length} habits successfully');
      return habits;
    } catch (e) {
      debugPrint('✗ Failed to fetch habits: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check Supabase configuration and database setup');
        debugPrint('   Ensure the habits table exists in your Supabase project');
      }
      rethrow;
    }
  }

  Future<Habit> createHabit(Habit habit) async {
    try {
      debugPrint('📝 Creating new habit: ${habit.title}');
      final response = await _supabase
          .from('habits')
          .insert(habit.toJson())
          .select()
          .single();

      debugPrint('✓ Habit created successfully');
      return Habit.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to create habit: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check habit data format');
        debugPrint('   Habit data: ${habit.toJson()}');
      }
      rethrow;
    }
  }

  Future<Habit> updateHabit(Habit habit) async {
    try {
      debugPrint('📝 Updating habit: ${habit.id}');
      final updatedHabit = habit.copyWith(updatedAt: DateTime.now());
      
      final response = await _supabase
          .from('habits')
          .update(updatedHabit.toJson())
          .eq('id', habit.id)
          .select()
          .single();

      debugPrint('✓ Habit updated successfully');
      return Habit.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to update habit: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check habit data format');
      }
      rethrow;
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      debugPrint('🗑️ Deleting habit: $habitId');
      await _supabase.from('habits').delete().eq('id', habitId);
      debugPrint('✓ Habit deleted successfully');
    } catch (e) {
      debugPrint('✗ Failed to delete habit: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check habit ID');
      }
      rethrow;
    }
  }

  Future<Habit> completeHabit(String habitId, String date) async {
    try {
      debugPrint('✅ Completing habit: $habitId for date: $date');
      // Get the habit
      final habitData = await _supabase
          .from('habits')
          .select()
          .eq('id', habitId)
          .single();

      final habit = Habit.fromJson(habitData);

      // Update completion history
      final updatedHistory = Map<String, bool>.from(habit.completionHistory);
      updatedHistory[date] = true;

      final updatedHabit = habit.copyWith(
        completionHistory: updatedHistory,
        updatedAt: DateTime.now(),
      );

      // Save to database
      final response = await _supabase
          .from('habits')
          .update(updatedHabit.toJson())
          .eq('id', habitId)
          .select()
          .single();

      debugPrint('✓ Habit completed successfully');
      return Habit.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to complete habit: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check habit ID and date format');
      }
      rethrow;
    }
  }

  Future<Habit> uncompleteHabit(String habitId, String date) async {
    try {
      debugPrint('❌ Uncompleting habit: $habitId for date: $date');
      // Get the habit
      final habitData = await _supabase
          .from('habits')
          .select()
          .eq('id', habitId)
          .single();

      final habit = Habit.fromJson(habitData);

      // Update completion history
      final updatedHistory = Map<String, bool>.from(habit.completionHistory);
      updatedHistory[date] = false;

      final updatedHabit = habit.copyWith(
        completionHistory: updatedHistory,
        updatedAt: DateTime.now(),
      );

      // Save to database
      final response = await _supabase
          .from('habits')
          .update(updatedHabit.toJson())
          .eq('id', habitId)
          .select()
          .single();

      debugPrint('✓ Habit uncompleted successfully');
      return Habit.fromJson(response);
    } catch (e) {
      debugPrint('✗ Failed to uncomplete habit: $e');
      if (e.toString().contains('400')) {
        debugPrint('⚠️ 400 Bad Request Error: Check habit ID and date format');
      }
      rethrow;
    }
  }

  /// Get completion streak for a habit
  int getStreak(Habit habit) {
    int streak = 0;
    DateTime checkDate = DateTime.now();

    while (true) {
      final dateKey = _formatDate(checkDate);
      if (habit.completionHistory[dateKey] == true) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
