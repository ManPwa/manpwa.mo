import 'package:dio/dio.dart';

class NetworkAccessError extends DioError {
  String statusCode;
  @override
  // ignore: overridden_fields
  String message;
  String code;

  DioError raw;
  Uri? uri;

  NetworkAccessError(this.statusCode, this.message, this.code, this.raw,
      [this.uri])
      : super(requestOptions: raw.requestOptions);

  factory NetworkAccessError.fromDioError(DioError dioError) {
    final requestUri = dioError.requestOptions.uri;

    String errorMessage = '';
    String errorCode = '';
    if (dioError.response?.data is String) {
      errorMessage = dioError.response!.data ?? 'Unknown error';
      errorCode = '';
    } else {
      errorMessage = _transformError(dioError);
      errorCode = dioError.response?.data['code']?.toString() ?? '';
    }

    return NetworkAccessError(
      dioError.response?.statusCode?.toString() ?? '',
      errorMessage,
      errorCode,
      dioError,
      requestUri,
    );
  }

  @override
  String toString() {
    return message;
  }
}

String _transformError(DioError dioError) {
  switch (dioError.type) {
    case DioErrorType.connectionTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return 'The request timed out';

    case DioErrorType.cancel:
      return 'The request cancelled';

    case DioErrorType.badResponse:
      if (dioError.response!.data is String) {
        return dioError.response!.data ?? 'Unknown error';
      }
      return dioError.response!.data?['message'] ?? 'Unknown error';

    default:
      return 'Unknown error: ${dioError.message}';
  }
}
