import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class HttpClient {
  // -------------------------------- CONSTANTS --------------------------------
  static const _connectTimeout = 120000;
  static const _receiveTimeout = 120000;
  static const _sendTimeout = 120000;
  static const _responseType = ResponseType.json;

  // ---------------------------------- FIELDS ---------------------------------
  final _dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      responseType: _responseType,
    ),
  );

  // --------------------------------- METHODS ---------------------------------
  Future<Response<TResponse>> send<TRequest, TResponse>({
    required String path,
    TRequest? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @disposeMethod
  void dispose() {
    _dio.close(force: true);
  }
}
