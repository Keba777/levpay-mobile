import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_models.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      // Backend returns LoggedInUserResponse structure inside 'data' or root
      // Based on responses.go: { "access_token": "...", "user": {...} }
      // Assuming direct mapping or simple wrap.
      // Adjusting based on common patterns. If backend wraps in {"data": ...}, inspect response.
      // responses.go shows simple struct serialization.

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/register',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout(String refreshToken) async {
    try {
      await _dioClient.dio.post(
        '/auth/logout',
        data: {'refresh_token': refreshToken},
      );
    } on DioException catch (e) {
      // Logout errors can be ignored safely sometimes, but we'll throw for now
      throw _handleError(e);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _dioClient.dio.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _dioClient.dio.post(
        '/auth/reset-password',
        queryParameters: {'token': token},
        data: {
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _dioClient.dio.get('/auth/me');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      // Parse backend error format
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        return Exception(data['message']);
      }
      if (data is Map && data.containsKey('error')) {
        return Exception(data['error']);
      }
    }
    return Exception(e.message ?? 'Unknown network error');
  }
}
