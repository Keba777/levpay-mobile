import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We can access user data from state if we wish, or just show static UI
    final user = context.select((AuthBloc bloc) {
      final state = bloc.state;
      return state is AuthAuthenticated ? state.user : null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("LevPay Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ${user?.firstName ?? 'User'}!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text("This is your dashboard."),
          ],
        ),
      ),
    );
  }
}
