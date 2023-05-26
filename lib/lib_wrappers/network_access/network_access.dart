import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';

import 'network_access_error.dart';

class NetworkAccess {
  late Dio _client;
  final Map<String, dynamic> Function()? getCustomHeaders;

  late StreamController<NetworkAccessError> _errorController;

  NetworkAccess(
    String baseUrl, {
    BaseOptions? customOptions,
    this.getCustomHeaders,
  }) {
    final options = customOptions ?? BaseOptions();
    _client = Dio(options.copyWith(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 30),
    ));

    _errorController = StreamController<NetworkAccessError>.broadcast();
    _setupInterceptors();
  }

  _setupInterceptors() {
    _client.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final customHeaders = getCustomHeaders?.call() ?? {};
          final clonedOptions = options.copyWith();
          clonedOptions.headers.addAll({...customHeaders});

          return handler.next(clonedOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          _errorController.add(NetworkAccessError.fromDioError(e));
          return handler.next(NetworkAccessError.fromDioError(e));
        },
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
      CurlLoggerDioInterceptor(),
    ]);
  }

  Future<Response<T>> _request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return _client.request<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method, headers: headers),
    );
  }

  Future<Response<T>> fetch<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<T>(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<dynamic>(
      path,
      data: data,
      method: 'POST',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<dynamic>> update(
    String path, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<dynamic>(
      path,
      data: data,
      method: 'PATCH',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<dynamic>> replace(
    String path, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<dynamic>(
      path,
      data: data,
      method: 'PUT',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<dynamic>(
      path,
      data: data,
      method: 'DELETE',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<Response<dynamic>> upload(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<dynamic>(
      path,
      data: data,
      method: 'POST',
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Dio get client => _client;

  Stream<NetworkAccessError> get error$ => _errorController.stream;

  void dispose() {
    _errorController.close();
  }
}
