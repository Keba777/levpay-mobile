import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/wallet_models.dart';

class WalletRepository {
  final DioClient _dioClient;

  WalletRepository(this._dioClient);

  Future<BalanceResponse> getBalance() async {
    try {
      final response = await _dioClient.dio.get('/wallet/balance');
      return BalanceResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<WalletResponse> getWallet() async {
    try {
      final response = await _dioClient.dio.get('/wallet');
      return WalletResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<WalletHistoryResponse> getHistory({
    int page = 1,
    int limit = 10,
    String? type,
    String? status,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/transaction/history',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (type != null) 'type': type,
          if (status != null) 'status': status,
        },
      );
      return WalletHistoryResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<TransactionItem> transfer({
    required String toEmail,
    required double amount,
    String? description,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        '/transaction/transfer',
        data: {
          'to_email': toEmail,
          'amount': amount,
          if (description != null) 'description': description,
        },
      );
      return TransactionItem.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<WalletResponse> topUp({
    required double amount,
    String currency = 'USD',
  }) async {
    try {
      final response = await _dioClient.dio.post(
        '/wallet/topup',
        data: {'amount': amount, 'currency': currency},
      );
      return WalletResponse.fromJson(response.data);
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
