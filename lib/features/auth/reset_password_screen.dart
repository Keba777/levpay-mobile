import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:levpay_mobile/core/theme/app_theme.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;
  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthResetPasswordRequested(
          token: widget.token,
          newPassword: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is AuthUnauthenticated) {
          // Assuming successful reset leads to unauthenticated (fresh login required)
          // But check if it was actually a logout or reset success.
          // Ideally we'd have a specific event/state, but for now let's assume if we are on this screen
          // and state becomes Unauthenticated (via the reset success in bloc), we show success.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password reset successfully. Please login."),
              backgroundColor: Colors.green,
            ),
          );
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Reset Password"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) => v!.length < 6 ? 'Min 6 chars' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) =>
                      v != _passwordController.text ? 'Mismatch' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.deepTeal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Reset Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
