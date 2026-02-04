import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/habit.dart';

class HabitsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Habit>> getUserHabits(String userId) async {
    final response = await _supabase
        .from('habits')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Habit.fromJson(json)).toList();
  }

  Future<Habit> createHabit(Habit habit) async {
    final response = await _supabase
        .from('habits')
        .insert(habit.toJson())
        .select()
        .single();

    return Habit.fromJson(response);
  }

  Future<Habit> updateHabit(Habit habit) async {
    final updatedHabit = habit.copyWith(updatedAt: DateTime.now());
    
    final response = await _supabase
        .from('habits')
        .update(updatedHabit.toJson())
        .eq('id', habit.id)
        .select()
        .single();

    return Habit.fromJson(response);
  }

  Future<void> deleteHabit(String habitId) async {
    await _supabase.from('habits').delete().eq('id', habitId);
  }

  Future<Habit> completeHabit(String habitId, String date) async {
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

    return Habit.fromJson(response);
  }

  Future<Habit> uncompleteHabit(String habitId, String date) async {
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

    return Habit.fromJson(response);
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
