
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/auth/domain/entities/app_user.dart';
import 'package:pms/features/auth/domain/repo/auth_repo.dart';
import 'package:pms/features/auth/presentation/cubits/auth_states.dart';
import 'package:pms/core/utils/my_log.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
      MyLog.success('User authenticated: ${user.uid}');
    } else {
      MyLog.info('No authenticated user found');
      emit(Unauthenticated());
    }
  }

  AppUser? get currentUser => _currentUser;

  void signOut() async {
    await authRepo.signOut();
    _currentUser = null;
    emit(Unauthenticated());
    MyLog.info('User signed out');
  }


void forgotPassword(String email) async {
    try {
      await authRepo.forgotPassword(email);
      MyLog.info('Password reset email sent to $email');
    } catch (e) {
      MyLog.error('Error sending password reset email: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginInWithEmailAndPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
        MyLog.success('User authenticated: ${user.uid}');
      } else {
        MyLog.info('login failed: No authenticated user found');
        emit(Unauthenticated());
      }
    } catch (e) {
      MyLog.error('Error occurred while logging in: $e');
      emit(AuthErrors(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.signUpWithEmailAndPassword(
        name,
        email,
        password,
      );
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
        MyLog.success('User signed up and authenticated: ${user.uid}');
      } else {
        MyLog.info('Sign up failed: No authenticated user found');
        emit(Unauthenticated());
      }
    } catch (e) {
      MyLog.error('Error occurred while signing up: $e');
      emit(AuthErrors(e.toString()));
      emit(Unauthenticated());
    }
  }
}
