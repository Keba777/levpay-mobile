import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/kyc_models.dart';

class KYCRepository {
  final DioClient _dioClient;

  KYCRepository(this._dioClient);

  Future<KYCStatusResponse> getStatus() async {
    try {
      final response = await _dioClient.dio.get('/kyc/status');
      return KYCStatusResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> uploadDocument(String type, File file) async {
    try {
      final formData = FormData.fromMap({
        'type': type,
        'document': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      await _dioClient.dio.post(
        '/kyc/upload',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
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
    }
    return Exception(e.message ?? 'Unknown network error');
  }
}
