import 'package:dio/dio.dart';

import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
  });

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
            message: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: 'Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Receive timeout with API server');
      case DioExceptionType.badCertificate:
        return const ServerFailure(message: 'Bad certificate with API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response?.statusCode ?? 500,
          e.response?.data ?? 'Bad response from server',
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
            message: 'Request to API server was canceled');
      case DioExceptionType.connectionError:
        return const ServerFailure(message: 'No internet connection');
      case DioExceptionType.unknown:
        return const ServerFailure(
            message: 'Oops! There was an error, pleaSe try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerFailure(
          message: 'Your request was not found, pleaSe try later');
    } else if (statusCode == 500) {
      return const ServerFailure(
          message: 'There is a problem with the server, pleaSe try later');
    } else if (statusCode == 429) {
      return const ServerFailure(
          message: 'You have made too many requests. PleaSe try again later.');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
          message: response['error']['message'] ?? 'Unauthorized request');
    } else {
      print('ServerFailure.fromResponse: $response');
      print('ServerFailure.fromResponse: $statusCode');
      return const ServerFailure(
          message: 'There was an error, pleaSe try again later');
    }
  }
}
