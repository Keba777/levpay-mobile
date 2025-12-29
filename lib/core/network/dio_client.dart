import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  DioClient(this._dio, this._storage) {
    _dio
      ..options.baseUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:4003/api'
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await _storage.read(key: 'access_token');
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (DioException e, handler) {
            // Handle global errors like 401 Unauthorized if needed
            return handler.next(e);
          },
        ),
      );
  }

  Dio get dio => _dio;
}
