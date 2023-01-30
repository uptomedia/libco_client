import 'package:chegg/core/exceptions/app_exceptions.dart';
import 'package:chegg/core/features/feature/domain/entities/error_model.dart';
import 'package:chegg/core/helper_functions.dart';
import 'package:chegg/core/utils.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse.loading([this.message = '']) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.noInternet() : status = Status.NO_INTERNET;

  ApiResponse.noItems() : status = Status.NO_ITEMS;

  /// you can send error model or an exception
  ApiResponse.error(error, [context]) {
    status = Status.ERROR;
    try {
      if (AppHelperFunctions.checkIfIsSubType<Exception>(error) ||
          AppHelperFunctions.checkIfIsSubType<Error>(error)) {
        // if(AppHelperFunctions.inReleaseMode)
        //     message = S.of(context).unknown;
        //   else
        message = error?.toString();

        if (AppHelperFunctions.checkIfSubOrSameType<ServerErrorException>(
            error)) {
          var err = ErrorEntity.fromJson(error.questionData['error']);
          message = Utils.getErrorMessageFromModel(err);
        }
      } else if (AppHelperFunctions.checkIfIsSubType<ErrorEntity>(error)) {
        message = Utils.getErrorMessageFromModel(error as ErrorEntity,
            withDetails: !AppHelperFunctions.inReleaseMode);
      } else if (error is String) message = error;
    } catch (e) {
      message = 'Server error';
    }
  }

  ApiResponse.idle([this.message = '']) : status = Status.IDLE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, IDLE, NO_ITEMS, NO_INTERNET }
