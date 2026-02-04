import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String category;
  final int level;
  final int currentProgress;
  final int maxProgress;
  final String iconName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Skill({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.category = 'general',
    this.level = 1,
    this.currentProgress = 0,
    this.maxProgress = 100,
    this.iconName = 'default',
    required this.createdAt,
    required this.updatedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String? ?? 'general',
      level: json['level'] as int? ?? 1,
      currentProgress: json['current_progress'] as int? ?? 0,
      maxProgress: json['max_progress'] as int? ?? 100,
      iconName: json['icon_name'] as String? ?? 'default',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'category': category,
      'level': level,
      'current_progress': currentProgress,
      'max_progress': maxProgress,
      'icon_name': iconName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Skill copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? category,
    int? level,
    int? currentProgress,
    int? maxProgress,
    String? iconName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Skill(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      level: level ?? this.level,
      currentProgress: currentProgress ?? this.currentProgress,
      maxProgress: maxProgress ?? this.maxProgress,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
        category,
        level,
        currentProgress,
        maxProgress,
        iconName,
        createdAt,
        updatedAt,
      ];
}
