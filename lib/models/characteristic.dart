import 'package:equatable/equatable.dart';

class Characteristic extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final int level;
  final int maxLevel;
  final String statType; // strength, agility, etc.
  final DateTime createdAt;
  final DateTime updatedAt;

  const Characteristic({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.level = 1,
    this.maxLevel = 10,
    required this.statType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      level: json['level'] as int? ?? 1,
      maxLevel: json['max_level'] as int? ?? 10,
      statType: json['stat_type'] as String,
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
      'level': level,
      'max_level': maxLevel,
      'stat_type': statType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Characteristic copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    int? level,
    int? maxLevel,
    String? statType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Characteristic(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      level: level ?? this.level,
      maxLevel: maxLevel ?? this.maxLevel,
      statType: statType ?? this.statType,
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
        level,
        maxLevel,
        statType,
        createdAt,
        updatedAt,
      ];
}
