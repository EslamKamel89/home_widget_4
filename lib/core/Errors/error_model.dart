// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:trading/core/api/end_points.dart';
// import 'package:trading/core/crud/status_request.dart';

// class ErrorModel {
//   String? status;
//   bool? error;
//   String? errorMessageAr;
//   String? errorMessageEn;
//   StatusRequest? statusRequest;
//   ErrorModel({
//     this.status,
//     this.error,
//     this.errorMessageAr,
//     this.errorMessageEn,
//     this.statusRequest,
//   });
//   factory ErrorModel.fromJson(Map<String, dynamic> json) {
//     return ErrorModel(
//       status: json[ApiKey.status],
//       error: json[ApiKey.error],
//       errorMessageAr: json[ApiKey.messageAr],
//       errorMessageEn: json[ApiKey.messageEn],
//     );
//   }

//   @override
//   String toString() {
//     return 'ErrorModel(status: $status, error: $error, errorMessageAr: $errorMessageAr, errorMessageEn: $errorMessageEn, statusRequest: $statusRequest)';
//   }

//   static ErrorModel offlineError = ErrorModel(
//     error: true,
//     status: ApiKey.fail,
//     errorMessageAr: "Check Your Internet Connection",
//     errorMessageEn: "Check Your Internet Connection",
//     statusRequest: StatusRequest.offlineFailure,
//   );
//   static ErrorModel serverFailure({int? statusCode}) => ErrorModel(
//         error: true,
//         status: ApiKey.fail,
//         errorMessageAr: 'Counld not connect with the server, status Code ${statusCode ?? 'Not Defined'}',
//         errorMessageEn: 'Counld not connect with the server, status Code ${statusCode ?? 'Not Defined'}',
//         statusRequest: StatusRequest.serverFailure,
//       );
//   static ErrorModel? checkResponse(Map<String, dynamic> json) {
//     final errorModel = ErrorModel.fromJson(json);
//     if ((errorModel.error ?? false) || errorModel.status == ApiKey.fail) {
//       errorModel.statusRequest = StatusRequest.error;

//       return errorModel;
//     }
//     return null;
//   }
// }
