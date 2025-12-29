import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:levpay_mobile/features/auth/login_screen.dart';
import 'package:levpay_mobile/features/auth/register_screen.dart';
import 'package:levpay_mobile/features/auth/forgot_password_screen.dart';
import 'package:levpay_mobile/features/auth/reset_password_screen.dart';
import 'package:levpay_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:levpay_mobile/features/wallet/presentation/screens/send_money_screen.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:levpay_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // For context.read
import 'package:levpay_mobile/features/kyc/presentation/screens/kyc_screen.dart';
import 'package:levpay_mobile/features/user/presentation/screens/settings_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      $loginRoute,
      $registerRoute,
      $forgotPasswordRoute,
      $resetPasswordRoute,
      $homeRoute,
      $sendMoneyRoute,
      $kYCRoute,
      $settingsRoute,
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggingIn =
          state.uri.path == '/login' ||
          state.uri.path == '/register' ||
          state.uri.path == '/forgot-password' ||
          state.uri.path == '/reset-password';

      if (authState is AuthUnauthenticated && !isLoggingIn) {
        return '/login';
      }
      if (authState is AuthAuthenticated && isLoggingIn) {
        return '/home';
      }
      return null;
    },
    debugLogDiagnostics: true,
  );
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterScreen();
}

@TypedGoRoute<ForgotPasswordRoute>(path: '/forgot-password')
class ForgotPasswordRoute extends GoRouteData {
  const ForgotPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPasswordScreen();
}

@TypedGoRoute<ResetPasswordRoute>(path: '/reset-password')
class ResetPasswordRoute extends GoRouteData {
  final String token;
  const ResetPasswordRoute({required this.token});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ResetPasswordScreen(token: token);
}

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<SendMoneyRoute>(path: '/send-money')
class SendMoneyRoute extends GoRouteData {
  const SendMoneyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SendMoneyScreen();
}

@TypedGoRoute<KYCRoute>(path: '/kyc')
class KYCRoute extends GoRouteData {
  const KYCRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const KYCScreen();
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
