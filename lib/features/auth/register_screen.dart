import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'presentation/bloc/auth_bloc.dart';
import 'presentation/bloc/auth_event.dart';
import 'presentation/bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthRegisterRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phone: _phoneController.text.trim(),
        ),
      );
    }
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
              content: Text('Account created! Welcome ${state.user.firstName}'),
              backgroundColor: AppTheme.deepTeal,
            ),
          );
          // context.go('/home'); // Navigate to home
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              "Create Account",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Start your journey with LevPay",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: "First Name",
                            ),
                            validator: (v) =>
                                v?.isEmpty == true ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                            ),
                            validator: (v) =>
                                v?.isEmpty == true ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (v) => v!.length < 6 ? 'Min 6 chars' : null,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppTheme.deepTeal,
                        foregroundColor: Colors.white,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text("Sign Up"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
