import 'package:levpay_mobile/core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminRepository {
  final DioClient _dioClient;

  AdminRepository(this._dioClient, FlutterSecureStorage storage);

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _dioClient.dio.get('/admin/dashboard');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> listUsers({
    int page = 1,
    int limit = 20,
    String search = "",
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/admin/users',
        queryParameters: {'page': page, 'limit': limit, 'search': search},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
