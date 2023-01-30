class ApiCodes {
  static const String SUCCESS = "Success";
  static const int SUCCESS_CODE = 1;

  static const String TWO_FACTORS_AUTH = "Login with two factors is needed";
  static const int TWO_FACTORS_AUTH_CODE = 2;

  static const String NOT_FOUND = "Not found";
  static const int NOT_FOUND_CODE = -1;

  static const String BAD_REQUEST = "Bad request";
  static const int BAD_REQUEST_CODE = -2;

  static const String SOMETHING_WRONG = "Something went wrong";
  static const int SOMETHING_WRONG_CODE = -3;

  static const String LOCKOUT = "Lockout";
  static const int LOCKOUT_CODE = -4;

  static const String INVALID_LOGIN = "Invalid login attempt";
  static const int INVALID_LOGIN_CODE = -5;

  static const String NOT_VERIFIED =
      "User account not verified, please check your email for verification code";
  static const int NOT_VERIFIED_CODE = -6;

  static const String Access_Denied = "Access denied";
  static const int Access_Denied_CODE = -7;

  static const String INVALID_INPUT = "Invalide Input";
  static const int INVALID_INPUT_CODE = -8;

  static const String CONFIRMATION_EMAIL_TYPE = "confirm_mail";
  static const String RESET_PASSWORD_EMAIL_TYPE = "reset_password";
  static const String DELETE_ACCOUNT_EMAIL_TYPE = "delete_account";
}
