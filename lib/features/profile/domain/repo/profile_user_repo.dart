
import 'package:pms/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  //
  Future<ProfileUser?> fetchUserProfile(String uid);

  //
  Future<void> updateUserProfile(ProfileUser updatedProfile);
  //
}
