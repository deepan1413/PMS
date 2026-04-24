import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/active_task/data/firebase_task_repo.dart';
import 'package:pms/features/active_task/presentation/cubits/task_cubit.dart';
import 'package:pms/features/auth/data/firebase_auth_repo.dart';
import 'package:pms/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:pms/features/auth/presentation/cubits/auth_states.dart';
import 'package:pms/features/auth/presentation/pages/auth_page.dart';
import 'package:pms/features/completed_task/presentation/cubits/completed_task_cubit.dart';
import 'package:pms/features/home/presentation/pages/home_page.dart';
import 'package:pms/features/profile/data/firebase_profile_repo.dart';
import 'package:pms/features/profile/presentation/cubits/profile_cubits.dart';
import 'package:pms/core/utils/my_log.dart';
import 'package:pms/core/themes/theme_cubit.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();
  final taskRepo = FirebaseTaskRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //auth cubit
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        //profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepo: profileRepo),
        ),

        //active task cubit
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(taskRepo: taskRepo),
        ),


         BlocProvider<CompletedTaskCubit>(
          create: (context) => CompletedTaskCubit(taskRepo: taskRepo),
        ),
        // Theme Cubit
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData,
            debugShowCheckedModeBanner: false,
            home: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, authState) {
                MyLog.info('Auth State: $authState');
                if (authState is Unauthenticated) {
                  return AuthPage();
                }
                if (authState is Authenticated) {
                  return HomePage();
                } else {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
              },
              listener: (context, authState) {
                if (authState is AuthErrors) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(authState.message)));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
