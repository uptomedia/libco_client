import 'package:chegg/core/features/feature/domain/entities/entity.dart';

abstract class ResponseModel {
  static const CONTENT_KEY = 'content';
  //
  // T? content;
  // String? result;
  // dynamic error_description;
  // int? error_code;
  // // String targetUrl;
  // // bool success;
  // // ErrorModel error;
  // // bool unAuthorizedRequest;
  // // bool __abp;
  //
  // // BaseResponseModel.fromJson(Map<String,dynamic> parsedJson){
  // //   BaseResponseModel(
  // //       parsedJson['targetUrl'],
  // //       parsedJson['success'],
  // //       parsedJson['error'] == null ? null : ErrorModel.fromJson(parsedJson['error']),
  // //       parsedJson['unAuthorizedRequest'],
  // //       parsedJson['__abp']);
  // // }
  // ResponseModel();
  // ResponseModel.fromJson(Map<String, dynamic> json){
  //   result = json['result'];
  //   error_description = json['error_description'];
  //   error_code = json['error_code'];
  // }
  //
  fromJson(Map<String, dynamic> json);
  Entity toEntity();
}
