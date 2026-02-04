import 'package:flutter_test/flutter_test.dart';
import 'package:arise_app/utils/xp_calculator.dart';
import 'package:arise_app/models/user_profile.dart';

void main() {
  group('XpCalculator Tests', () {
    test('Calculate XP for level 1', () {
      final xp = XpCalculator.xpForLevel(1);
      expect(xp, 100);
    });

    test('Calculate XP reward based on difficulty', () {
      final easyXp = XpCalculator.calculateXpReward(difficulty: 'easy');
      final mediumXp = XpCalculator.calculateXpReward(difficulty: 'medium');
      final hardXp = XpCalculator.calculateXpReward(difficulty: 'hard');

      expect(easyXp, 10);
      expect(mediumXp, 25);
      expect(hardXp, 50);
    });

    test('Calculate XP reward with duration bonus', () {
      final xpWithDuration = XpCalculator.calculateXpReward(
        difficulty: 'easy',
        durationMinutes: 20,
      );

      // 10 base + 10 duration bonus (20 min / 2)
      expect(xpWithDuration, 20);
    });
  });

  group('UserProfile Tests', () {
    test('Create UserProfile from JSON', () {
      final json = {
        'id': '123',
        'email': 'test@example.com',
        'display_name': 'Test Hunter',
        'player_class': 'Warrior',
        'level': 5,
        'current_xp': 50,
        'xp_to_next_level': 200,
        'skill_points': 3,
        'stats': {
          'strength': 15,
          'agility': 12,
          'intelligence': 10,
          'vitality': 14,
          'sense': 11,
        },
        'created_at': '2024-01-01T00:00:00.000Z',
        'updated_at': '2024-01-01T00:00:00.000Z',
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.id, '123');
      expect(profile.email, 'test@example.com');
      expect(profile.displayName, 'Test Hunter');
      expect(profile.playerClass, 'Warrior');
      expect(profile.level, 5);
      expect(profile.stats['strength'], 15);
    });

    test('UserProfile copyWith works correctly', () {
      final profile = UserProfile(
        id: '123',
        email: 'test@example.com',
        level: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final updated = profile.copyWith(level: 2, currentXp: 50);

      expect(updated.level, 2);
      expect(updated.currentXp, 50);
      expect(updated.email, 'test@example.com'); // Unchanged
    });
  });
}
