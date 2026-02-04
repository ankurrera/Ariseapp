import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String category;
  final int xpReward;
  final Map<String, bool> completionHistory; // date: completed
  final DateTime createdAt;
  final DateTime updatedAt;

  const Habit({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.category = 'general',
    this.xpReward = 10,
    this.completionHistory = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      category: json['category'] as String? ?? 'general',
      xpReward: json['xp_reward'] as int? ?? 10,
      completionHistory: json['completion_history'] != null
          ? Map<String, bool>.from(json['completion_history'] as Map)
          : const {},
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'category': category,
      'xp_reward': xpReward,
      'completion_history': completionHistory,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Habit copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? category,
    int? xpReward,
    Map<String, bool>? completionHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Habit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      xpReward: xpReward ?? this.xpReward,
      completionHistory: completionHistory ?? this.completionHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        category,
        xpReward,
        completionHistory,
        createdAt,
        updatedAt,
      ];
}
