import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/auth/presentation/components/my_text_filed.dart';
import 'package:pms/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:pms/core/utils/my_log.dart';
import 'package:pms/core/themes/app_colors.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onToggle;
  const LoginPage({super.key, required this.onToggle});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool ispasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      ispasswordVisible = !ispasswordVisible;
    });
  }

  void handleForgotPassword() {
    final String email = _emailController.text;
    if (email.isNotEmpty) {
      context.read<AuthCubit>().forgotPassword(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent if the email is registered'),
        ),

      );
      _emailController.clear();
    } else {
      MyLog.error('Email cannot be empty for password reset');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email to reset password'),
        ),
      );
    }
  }

  void handleLogin() {
    debugPrint("Login clicked");
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final authCubit = context.read<AuthCubit>();
    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      MyLog.error('Email and password cannot be empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password cannot be empty')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 48),
              MyTextFiled(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                suffixIcon: null,
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              MyTextFiled(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                isObscure: !ispasswordVisible,
                prefixIcon: const Icon(Icons.lock_outline),

                suffixIcon: IconButton(
                  icon: Icon(
                    ispasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),

              // Forgot Password UI
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: handleForgotPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: widget.onToggle,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.amber400,
                        // color:Theme.of( context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
