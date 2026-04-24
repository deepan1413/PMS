import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pms/features/profile/domain/entities/profile_user.dart';
import 'package:pms/features/profile/domain/repo/profile_user_repo.dart';
import 'package:pms/core/utils/my_log.dart';

class FirebaseProfileRepo implements ProfileRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          MyLog.success("Fetched user profile successfully $userData");
          //return ProfileUser.fromJson(userData);
          final activeTasks = List<String>.from(userData['activeTasks'] ?? []);
          final completedTasks = List<String>.from(
            userData['completedTasks'] ?? [],
          );
          return ProfileUser(
            bio: userData['bio'] ?? '',
            activeTasks: activeTasks,
            completedTasks: completedTasks,
            uid: uid,
            email: userData['email'],
            name: userData['name'],
          );
        }
      }
      return null;
    } catch (e) {
      MyLog.error('Error fetching user profile: $e');
      print('Error fetching user profile: $e');
      return null;
    }
  }

  @override
  Future<void> updateUserProfile(ProfileUser updatedProfile) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(updatedProfile.uid)
          .update({'bio': updatedProfile.bio,
            'activeTasks': updatedProfile.activeTasks,
            'completedTasks': updatedProfile.completedTasks,
          });
      MyLog.success("User profile updated successfully");
    } catch (e) {
      MyLog.error('Error updating user profile: $e');
      print('Error updating user profile: $e');
      throw Exception('Error updating user profile: $e');
    }
  }
}
