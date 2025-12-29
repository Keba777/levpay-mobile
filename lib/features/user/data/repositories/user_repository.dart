import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_models.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  Future<SearchResponse> searchUsers(String query) async {
    try {
      final response = await _dioClient.dio.get(
        '/users/search',
        queryParameters: {'query': query},
      );
      return SearchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    try {
      final response = await _dioClient.dio.get('/users/me');
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? firstName,
    String? lastName,
    String? username,
    String? phone,
    String? avatarPath,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (firstName != null) data['first_name'] = firstName;
      if (lastName != null) data['last_name'] = lastName;
      if (username != null) data['username'] = username;
      if (phone != null) data['phone'] = phone;

      if (avatarPath != null) {
        final formData = FormData.fromMap({
          ...data,
          'avatar': await MultipartFile.fromFile(
            avatarPath,
            filename: avatarPath.split('/').last,
          ),
        });
        final response = await _dioClient.dio.put('/users/me', data: formData);
        return response.data;
      } else {
        final response = await _dioClient.dio.put('/users/me', data: data);
        return response.data;
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getSettings() async {
    try {
      final response = await _dioClient.dio.get('/users/settings');
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateSettings(
    Map<String, dynamic> preferences,
  ) async {
    try {
      final response = await _dioClient.dio.put(
        '/users/settings',
        data: preferences,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
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
