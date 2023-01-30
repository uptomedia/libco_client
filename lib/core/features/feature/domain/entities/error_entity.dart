import 'package:chegg/core/exceptions/app_exceptions.dart';

class ErrorEntity {
  String? errorMessage;

  ErrorEntity(this.errorMessage);

  ErrorEntity.fromException(AppException e) {
    errorMessage = e.message;
  }
}
