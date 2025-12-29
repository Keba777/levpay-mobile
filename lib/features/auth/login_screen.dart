import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'presentation/bloc/auth_bloc.dart';
import 'presentation/bloc/auth_event.dart';
import 'presentation/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome ${state.user.firstName}!'),
              backgroundColor: AppTheme.deepTeal,
            ),
          );
          context.go('/home');
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  // Header Section
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTheme.deepTeal,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -50,
                          right: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppTheme.mintGreen.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/logo/Icon -  White.svg",
                                    width: 64,
                                    height: 64,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Welcome Back",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  "Sign in to continue",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Section
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 32),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Email Address",
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: AppTheme.deepTeal,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppTheme.deepTeal,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: AppTheme.deepTeal),
                                ),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: isLoading ? null : _handleLogin,
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text("Login"),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                GestureDetector(
                                  onTap: () => context.push('/register'),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: AppTheme.deepTeal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
