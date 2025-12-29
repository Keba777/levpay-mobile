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
