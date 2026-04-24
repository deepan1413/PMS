import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/profile/domain/entities/profile_user.dart';
import 'package:pms/features/profile/domain/repo/profile_user_repo.dart';
import 'package:pms/features/profile/presentation/cubits/profile_states.dart';
import 'package:pms/core/utils/my_log.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);

      // Fetch task counts from Firestore
      final firestore = FirebaseFirestore.instance;
      final activeDocs = await firestore
          .collection('tasks')
          .where('uid', isEqualTo: uid)
          .where('isCompleted', isEqualTo: false)
          .get();
      final completedDocs = await firestore
          .collection('tasks')
          .where('uid', isEqualTo: uid)
          .where('isCompleted', isEqualTo: true)
          .get();

      final updatedUser = ProfileUser(
        uid: user!.uid,
        name: user.name,
        email: user.email,
        bio: user.bio,
        activeTasks: activeDocs.docs.map((d) => d.id).toList(),
        completedTasks: completedDocs.docs.map((d) => d.id).toList(),
      );
      emit(ProfileLoaded(updatedUser));
    } catch (e) {
      MyLog.error('Error fetching user profile: $e');
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateBio({required String uid, required String newBio}) async {
    try {
      final currentState = state;
      if (currentState is! ProfileLoaded) return;

      final updatedUser = currentState.user.copyWith(newBio: newBio);
      await profileRepo.updateUserProfile(updatedUser);

      emit(ProfileLoaded(updatedUser));
    } catch (e) {
      MyLog.error('Error updating bio: $e');
      emit(ProfileError(e.toString()));
    }
  }
}
