import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart'; // Kept as it might be used for pop, but lint didn't complain about this one?
// Lint complained about auth_state.dart
import 'package:go_router/go_router.dart';
import 'package:levpay_mobile/core/theme/app_theme.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_event.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthForgotPasswordRequested(email: _emailController.text.trim()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("If the email exists, a reset link has been sent."),
          backgroundColor: AppTheme.deepTeal,
        ),
      );
      context.pop(); // Go back to login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter your email address to receive a password reset link.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.deepTeal,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Send Reset Link"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
