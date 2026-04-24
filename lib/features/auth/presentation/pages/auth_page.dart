
import 'package:flutter/material.dart';
import 'package:pms/features/auth/presentation/pages/login_page.dart';
import 'package:pms/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLoginPage = true;
  void _togglePage() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginPage(onToggle: _togglePage);
    } else {
      return RegisterPage(onToggle: _togglePage);
    }
  }
}
