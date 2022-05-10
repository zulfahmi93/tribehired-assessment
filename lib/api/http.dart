import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class HttpClient {
  // ------------------------------- CONSTRUCTORS ------------------------------
  HttpClient() {
    _dio.interceptors.add(_LoggerInterceptor());
  }

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
    return _dio.request<TResponse>(
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

class _LoggerInterceptor extends Interceptor {
  // ------------------------------- METHODS ------------------------------
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!Logger.root.isLoggable(Level.FINER)) {
      handler.next(options);
      return;
    }

    Logger.root.finer('');
    Logger.root.finer('Sending request to ${options.uri}:');
    Logger.root.finer('');

    if (options.headers.isNotEmpty) {
      Logger.root.finer('Request headers: ');
      options.headers.forEach(
        (key, value) => Logger.root.finer('$key: ${value.toString()}'),
      );
      Logger.root.finer('');
    }

    if (options.data != null) {
      _printObjectInJson(options.data, 'Request data:');
      _printFormDataObject(options.data, 'Request data:');
      Logger.root.finer('');
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (!Logger.root.isLoggable(Level.FINER)) {
      handler.next(response);
      return;
    }

    final requestUri = response.requestOptions.uri;
    Logger.root.finer('');
    _printObjectInJson(response.data, '$requestUri response:');
    Logger.root.finer('');

    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!Logger.root.isLoggable(Level.WARNING)) {
      handler.next(err);
      return;
    }

    final request = err.requestOptions;
    final response = err.response;

    Logger.root.warning('');
    Logger.root.warning('Error sending request to ${request.uri}!');
    if (response != null) {
      if (response.statusCode != null) {
        Logger.root.warning('HTTP Status Code: ${response.statusCode}');
      }
      final msg = response.statusMessage;
      if (msg == null || msg.isEmpty) {
        Logger.root.warning('HTTP Status Code: $msg');
      }
    }
    Logger.root.warning('');

    handler.next(err);
  }

  void _printObjectInJson(dynamic obj, String log) {
    if (obj is FormData) {
      return;
    }

    const encoder = JsonEncoder.withIndent('  ');
    final json = encoder.convert(obj);
    final lines = LineSplitter.split(json).toList();

    Logger.root.finer(log);
    Logger.root.finer('');
    for (final line in lines) {
      Logger.root.finer(line);
    }
  }

  void _printFormDataObject(dynamic obj, String log) {
    if (obj is! FormData) {
      return;
    }

    Logger.root.finer(log);
    Logger.root.finer('');
    for (final file in obj.files) {
      Logger.root.finer('[File] ${file.key}: ${file.value.filename}');
    }
    for (final field in obj.fields) {
      Logger.root.finer('[Field] ${field.key}: ${field.value}');
    }
  }
}
