import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;
  final String playerClass; // Warrior, Assassin, Mage
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final int skillPoints;
  final Map<String, int> stats; // strength, agility, intelligence, etc.
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.playerClass = 'Warrior',
    this.level = 1,
    this.currentXp = 0,
    this.xpToNextLevel = 100,
    this.skillPoints = 0,
    this.stats = const {
      'strength': 10,
      'agility': 10,
      'intelligence': 10,
      'vitality': 10,
      'sense': 10,
    },
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      playerClass: json['player_class'] as String? ?? 'Warrior',
      level: json['level'] as int? ?? 1,
      currentXp: json['current_xp'] as int? ?? 0,
      xpToNextLevel: json['xp_to_next_level'] as int? ?? 100,
      skillPoints: json['skill_points'] as int? ?? 0,
      stats: json['stats'] != null
          ? Map<String, int>.from(json['stats'] as Map)
          : const {
              'strength': 10,
              'agility': 10,
              'intelligence': 10,
              'vitality': 10,
              'sense': 10,
            },
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'player_class': playerClass,
      'level': level,
      'current_xp': currentXp,
      'xp_to_next_level': xpToNextLevel,
      'skill_points': skillPoints,
      'stats': stats,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    String? avatarUrl,
    String? playerClass,
    int? level,
    int? currentXp,
    int? xpToNextLevel,
    int? skillPoints,
    Map<String, int>? stats,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      playerClass: playerClass ?? this.playerClass,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      skillPoints: skillPoints ?? this.skillPoints,
      stats: stats ?? this.stats,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        avatarUrl,
        playerClass,
        level,
        currentXp,
        xpToNextLevel,
        skillPoints,
        stats,
        createdAt,
        updatedAt,
      ];
}
