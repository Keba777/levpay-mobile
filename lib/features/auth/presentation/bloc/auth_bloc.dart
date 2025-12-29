import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final FlutterSecureStorage _storage;

  AuthBloc({
    required AuthRepository authRepository,
    required FlutterSecureStorage storage,
  }) : _authRepository = authRepository,
       _storage = storage,
       super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
    on<AuthResetPasswordRequested>(_onAuthResetPasswordRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final token = await _storage.read(key: 'access_token');
    if (token != null) {
      try {
        final user = await _authRepository.getCurrentUser();
        emit(AuthAuthenticated(user));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      const fingerprint = "device-fingerprint-uuid";

      final response = await _authRepository.login(
        LoginRequest(
          email: event.email,
          password: event.password,
          fingerprint: fingerprint,
        ),
      );

      await _storage.write(key: 'access_token', value: response.accessToken);
      await _storage.write(key: 'refresh_token', value: response.refreshToken);

      emit(AuthAuthenticated(response.user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      const fingerprint = "device-fingerprint-uuid";

      final response = await _authRepository.register(
        RegisterRequest(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
          phone: event.phone,
          fingerprint: fingerprint,
        ),
      );

      await _storage.write(key: 'access_token', value: response.accessToken);
      await _storage.write(key: 'refresh_token', value: response.refreshToken);

      emit(AuthAuthenticated(response.user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final refreshToken = await _storage.read(key: 'refresh_token');

    if (refreshToken != null) {
      try {
        await _authRepository.logout(refreshToken);
      } catch (e) {
        // Ignore logout errors
      }
    }
    await _storage.deleteAll();
    emit(AuthUnauthenticated());
  }

  Future<void> _onAuthForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.forgotPassword(event.email);
      // We can emit a specific state or just stay Unauthenticated but show proper UI feedback via listeners
      // For simplicity, let's emit Unauthenticated but UI should handle the success message via other means?
      // Or we can add an AuthSuccess-like state. But typically forgot password just sends email.
      // Re-emitting Unauthenticated might be confusing.
      // Let's emit AuthUnauthenticated and handle success in UI by not seeing failure.
      // Better: we need a state "AuthMessage" or similar logic?
      // Actually, BlocListener can listen to *changes/events* but usually it listens to state.
      // Let's revert to Unauthenticated.
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAuthResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.resetPassword(
        token: event.token,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
