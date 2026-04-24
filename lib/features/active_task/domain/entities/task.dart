import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String uid;
  final String title;
  final String description;
  final String priority; 
  final double progress; 
  final bool isCompleted;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    required this.priority,
    required this.progress,
    required this.isCompleted,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'description': description,
      'priority': priority,
      'progress': progress,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      uid: json['uid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? 'low',
      progress: (json['progress'] ?? 0.0).toDouble(),
      isCompleted: json['isCompleted'] ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Task copyWith({
    String? title,
    String? description,
    String? priority,
    double? progress,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      uid: uid,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      progress: progress ?? this.progress,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }
}