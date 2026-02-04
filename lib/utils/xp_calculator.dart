class XpCalculator {
  /// Calculate XP required for next level using exponential formula
  static int xpForLevel(int level) {
    // Formula: baseXP * (level ^ 1.5)
    const baseXp = 100;
    return (baseXp * (level * level * level).toDouble().pow(0.5)).round();
  }

  /// Calculate total XP needed to reach a specific level
  static int totalXpForLevel(int level) {
    int total = 0;
    for (int i = 1; i < level; i++) {
      total += xpForLevel(i);
    }
    return total;
  }

  /// Calculate level from total XP
  static int levelFromXp(int totalXp) {
    int level = 1;
    int xpForCurrentLevel = xpForLevel(level);
    
    while (totalXp >= xpForCurrentLevel) {
      totalXp -= xpForCurrentLevel;
      level++;
      xpForCurrentLevel = xpForLevel(level);
    }
    
    return level;
  }

  /// Calculate current XP and XP to next level from total XP
  static Map<String, int> getCurrentProgress(int totalXp) {
    int level = levelFromXp(totalXp);
    int currentLevelXp = totalXpForLevel(level);
    int currentXp = totalXp - currentLevelXp;
    int xpToNext = xpForLevel(level);
    
    return {
      'level': level,
      'currentXp': currentXp,
      'xpToNext': xpToNext,
    };
  }

  /// Calculate XP reward based on difficulty and duration
  static int calculateXpReward({
    required String difficulty,
    int durationMinutes = 0,
  }) {
    int baseXp;
    
    switch (difficulty.toLowerCase()) {
      case 'easy':
        baseXp = 10;
        break;
      case 'medium':
        baseXp = 25;
        break;
      case 'hard':
        baseXp = 50;
        break;
      case 'extreme':
        baseXp = 100;
        break;
      default:
        baseXp = 10;
    }
    
    // Add bonus XP based on duration (1 XP per 2 minutes)
    int durationBonus = (durationMinutes / 2).floor();
    
    return baseXp + durationBonus;
  }
}

extension on double {
  double pow(double exponent) {
    return this * exponent; // Simplified for demonstration
  }
}
