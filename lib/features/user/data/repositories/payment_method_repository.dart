import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/payment_method_models.dart';

class PaymentMethodRepository {
  final DioClient _dioClient;

  PaymentMethodRepository({required DioClient dioClient})
    : _dioClient = dioClient;

  Future<List<PaymentMethod>> listPaymentMethods() async {
    try {
      final response = await _dioClient.dio.get('/payment-methods');
      final List<dynamic> data = response.data;
      return data.map((json) => PaymentMethod.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> addPaymentMethod({
    required String type,
    required Map<String, dynamic> details,
    bool isDefault = false,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        '/payment-methods',
        data: {'type': type, 'details': details, 'is_default': isDefault},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> removePaymentMethod(String id) async {
    try {
      await _dioClient.dio.delete('/payment-methods/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> setDefaultPaymentMethod(String id) async {
    try {
      await _dioClient.dio.patch('/payment-methods/$id/default');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception(e.response?.data['message'] ?? 'An error occurred');
    }
    return Exception('Network error: ${e.message}');
  }
}
