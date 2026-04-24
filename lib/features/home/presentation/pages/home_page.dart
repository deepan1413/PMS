import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/active_task/presentation/pages/active_task_page.dart';
import 'package:pms/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:pms/features/completed_task/presentation/pages/completed_task_page.dart';
import 'package:pms/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int _currentIndex = 0;
   late final uid = context.read<AuthCubit>();

  late final List<Widget> _screens = [
    const ActiveTaskPage(),
    CompletedTaskPage(uid: uid.currentUser!.uid), 
    const ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Active",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}