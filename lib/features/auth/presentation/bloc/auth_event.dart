import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthCheckRequested extends AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName, phone];
}

final class AuthLogoutRequested extends AuthEvent {}

final class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

final class AuthResetPasswordRequested extends AuthEvent {
  final String token;
  final String newPassword;
  final String confirmPassword;

  const AuthResetPasswordRequested({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [token, newPassword, confirmPassword];
}
