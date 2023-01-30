import 'package:intl/intl.dart';

class AppConfigurations {
  static const String ApplicationName = 'CHEGG';

  static const String BaseUrl = 'https://dev-leela-api.azurewebsites.net/api/';

  // static const String BaseUrl = 'http://163.172.14.250/cert/lila-api/api/';
  // static const String BaseIdentityUrl =
  //     'http://163.172.14.250/cert/lila-identity/api/';
  static const String BaseIdentityUrl =
      'https://dev-leela-identity.azurewebsites.net/api/';

  static const String BaseImagesUrl = 'https://jsonplaceholder.typicode.com/';

  static const String privacyPolicyUrl =
      "https://cert-leela-api.azurewebsites.net/privacypolicy.html";

  static const Map<String, String> BaseHeaders = {
    "accept": "text/plain",
    "Content-Type": "application/json",
  };

  static const GOOGLE_MAP_KEY = 'AIzaSyAB0E9skzggsaitNGRklPMlUydmYlpLBG8';

  /// formats
  static DateFormat appDisplayDateFormat = DateFormat('dd/MM/yyyy', 'en');
  static DateFormat appDisplayDateOfBirth = DateFormat('dd-MM-yyyy', 'en');
  static DateFormat appDisplayDateTimeFormat =
      DateFormat('dd/MM/yyyy   HH:mm  ', 'en');
  static DateFormat appointmentApiDateTimeFormat =
      DateFormat("E,d LLL yyyy HH:mm:ss", 'en'); // "Tue,13 Jul 2021 00:00:43 ",
  static DateFormat appointmentApiTimeFormat = DateFormat("HH:mm"); // "00:00",
  static DateFormat profileDateFormat =
      DateFormat("yyyy-MM-dd", 'en'); // "00:00",
  static DateFormat appointmentDateFormat =
      //DateFormat("yyyy-MM-dd hh:mm aa",'en');// "00:00",
      DateFormat("yyyy-MM-dd HH:mm ", 'en'); // "00:00",
  static DateFormat appointmentCreateApiDateTimeFormat =
      DateFormat("yyyy-MM-ddTHH:mm:ss", 'en');
  static DateFormat dayDispalyApiDateTimeFormat =
      DateFormat("EEEE d LLLL yyyy", 'en');
  static DateFormat hourDispalyApiDateTimeFormat = DateFormat("HH:mm a", 'en');
}
