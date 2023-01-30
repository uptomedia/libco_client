import 'dart:convert';

class UserInfo {
  int? id;
  String? email;
  String? phoneNumber;
  String? token;
  String? refreshToken;
  String? encToken;
  int? tokenExpireInSeconds;

  UserInfo(
      {this.id,
      this.email,
      this.phoneNumber,
      this.token,
      this.refreshToken,
      this.encToken,
      this.firebaseToken,
      this.tokenExpireInSeconds});

  /// firebase
  String? firebaseToken;

  UserInfo.fromJson(Map<String, dynamic>? parsedJson, {this.token}) {
    id = parsedJson!['id'];
    email = parsedJson['email'];
    phoneNumber = parsedJson['phone_number'];
  }

  Map<String, dynamic> asJson() {
    Map<String, dynamic>? res = {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'token': token,
      'refreshToken': refreshToken,
    };
    return res;
  }

  @override
  String toString() {
    var jres = jsonEncode(asJson());
    return jres;
  }
}

enum UserAuthMethod { email, phone }
