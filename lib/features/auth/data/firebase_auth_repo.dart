import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pms/features/auth/domain/entities/app_user.dart';
import 'package:pms/features/auth/domain/repo/auth_repo.dart';
import 'package:pms/core/utils/my_log.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return null;
      }
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) {
        MyLog.error(
          'User document does not exist for UID: ${firebaseUser.uid}',
        );
        return null;
      }
      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: userDoc['name'],
      );
    } catch (e) {
      MyLog.error('Error getting current user: $e');
      print('Error getting current user: $e');
    }
  }

  @override
  Future<AppUser?> loginInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: userDoc['name'],
      );
      return user;
    } catch (e) {
      MyLog.error('Error logging in with email and password: $e');
      print('Error logging in with email and password: $e');
      throw Exception('Error logging in with email and password: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      MyLog.error('Error signing out: $e');
      print('Error signing out: $e');
    }
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );
      await firestore.collection('users').doc(user.uid).set(user.toJson());
      return user;
    } catch (e) {
      MyLog.error('Error signing up with email and password: $e');
      print('Error signing up with email and password: $e');
      throw Exception('Error signing up with email and password: $e');
    }
  }

  @override
  Future<void> forgotPassword(String email) {
    try {
      return firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      MyLog.error('Error sending password reset email: $e');
      print('Error sending password reset email: $e');
      throw Exception('Error sending password reset email: $e');
    }
  }
}
