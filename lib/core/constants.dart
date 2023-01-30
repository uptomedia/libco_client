

import 'package:chegg/features/data/remote/models/countrys_rate_model.dart';
import 'package:chegg/generated/l10n.dart';

class Constants {
  // APP tabs indexes
  static String UID="";
  static List<CountrysRatesModel> countrysList=[];
  static String GOOGLE_MAP_KEY = 'AIzaSyA5hh7U5PxSlRKHCMW1C_JsR0wnBHSzalY';
}

// api requests types
/// type of request : [RequestType.POST] or [RequestType.GET]
enum RequestType { GET, POST, PUT, DELETE }

// api requests types
enum ParametersType { Body, Url }
