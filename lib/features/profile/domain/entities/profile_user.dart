import 'package:pms/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  String bio;

  List<String> activeTasks;
  List<String> completedTasks;

  ProfileUser({
    required this.bio,

    required this.activeTasks,
    required this.completedTasks,
    required super.uid,
    required super.email,
    required super.name,
  });

  // convert profile user to json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,

      'activeTasks': activeTasks,
      'completedTasks': completedTasks,
    };
  }

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'] ?? '',
      activeTasks: List<String>.from(json['activeTasks'] ?? []),
      completedTasks: List<String>.from(json['completedTasks'] ?? []),
    );
  }

  ProfileUser copyWith({
    String? newBio,
    List<String>? newActiveTasks,
    List<String>? newCompletedTasks,
  }) {
    return ProfileUser(
      uid: uid,
      email: email,
      name: name,
      bio: newBio ?? bio,
      activeTasks: newActiveTasks ?? activeTasks,
      completedTasks: newCompletedTasks ?? completedTasks,
    );
  }
}
