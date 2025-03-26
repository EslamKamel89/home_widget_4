import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.offline() {
    return ServerFailure('Check Your Interent Connection!');
  }
  factory ServerFailure.formDioError(DioException e) {
    String errorMessage = '';
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection Timeout with api server';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send Timeout with api server';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Recieve Timeout with api server';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad Certificate with api server';
        break;
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode ?? 404, e.response!.data);
      // errorMessage = 'Bad Response with api server';
      // break;
      case DioExceptionType.cancel:
        errorMessage = 'Request to Api server is canceled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No Internet Connection';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Opps There was an error, please try again';
        break;
    }
    return ServerFailure(errorMessage);
  }

  factory ServerFailure.fromResponse(int statusCode, Map data) {
    if (statusCode == 404) {
      return ServerFailure('Your Request Not Found, Please Try Later');
    } else if (statusCode >= 500) {
      return ServerFailure(
          'There are a problem with the server, Please Try Later');
      // status code == 400 >> bad respnse mainly wrong body sent to request
      // status code == 401 >> bad respnse mainly you send in the header wrong token
      // status code == 403 >> bad respnse mainly the token is correct but you are unauthorized to view this page
    } else if ([400, 401, 403].contains(statusCode)) {
      return ServerFailure(data['message']);
    }
    return ServerFailure('There was an error, Please try again later');
  }

  factory ServerFailure.unkownError() {
    return ServerFailure('Error Occured');
  }
}
