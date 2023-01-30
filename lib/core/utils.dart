import 'dart:async';

import 'package:chegg/core/features/feature/domain/entities/api_response.dart';
import 'package:chegg/core/features/feature/domain/entities/error_model.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'configurations/app_configuration.dart';
import 'configurations/styles.dart';
import 'constants.dart';
import 'features/feature/domain/entities/api_response.dart';
import 'helper_functions.dart';

class Utils {
  static String token = '';

  static GoogleMapsPlaces places =
      new GoogleMapsPlaces(apiKey: Constants.GOOGLE_MAP_KEY);

  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void showToastWithColor(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message);
  }

  static void pushNavigateTo(context, bool withNavBar, String route,
      {arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(route, arguments: arguments);
    });
  }

  void snackBarError({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
    scaffoldState!.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$msg"),
            // Icon(FontAwesome.exclamation_triangle)
          ],
        ),
      ),
    );
  }

  static Future<T?> pushNewScreenWithRouteSettings<T>(
    BuildContext context, {
    required Widget screen,
    required RouteSettings settings,
    bool? withNavBar,
    PageTransitionAnimation pageTransitionAnimation =
        PageTransitionAnimation.cupertino,
    PageRoute? customPageRoute,
  }) {
    if (withNavBar == null) {
      withNavBar = true;
    }

    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
        customPageRoute ??
            getPageRoute(pageTransitionAnimation,
                enterPage: screen, settings: settings));

    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
        customPageRoute as Route<T>? ??
            // getPageRoute(
            //     enterPage: screen, settings: settings));
            PageRouteBuilder(
                settings: settings,
                pageBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) =>
                    screen));
  }

  static void pushReplacementNavigateTo(context, String route, {arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
    });
  }

  static Future<T?> pushDynamicScreen<T>(BuildContext context, {
    required dynamic screen,
    bool? withNavBar,
  }) {
    if (withNavBar == null) {
      withNavBar = true;
    }
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(screen);
  }

  static void popNavigate(context, {int popsCount = 1, bool value = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < popsCount; i++) {
        Navigator.of(context).pop(value);
      }
    });
  }

  static void popNavigateToFirst(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  static void clearAndPush(context, newRouteName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(newRouteName, (route) => false);
    });
  }

  static void showError(BuildContext context, message, [title = '']) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AppHelperFunctions.inReleaseMode)
        WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  shape:
                      //MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Styles.ColorBlueTurquoise)),
                  title: new Text(title),
                  content: new Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    Center(
                        child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(70),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Styles.ColorBlueTurquoise,
                              Styles.ColorBlueTurquoiseEnd
                            ],
                          ),
                        ),
                        width: 200,
                        height: 40,
                        child: Center(child: Text(S.of(context).close)),
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    ))
                  ],
                )));
      else
      // Fluttertoast.showToast(msg: message);
      {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  shape:
                      //MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Styles.ColorBlueTurquoise)),
                  title: new Text(title),
                  content: new Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    Center(
                        child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(70),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Styles.ColorBlueTurquoise,
                              Styles.ColorBlueTurquoiseEnd
                            ],
                          ),
                        ),
                        width: 200,
                        height: 40,
                        child: Center(child: Text(S.of(context).close)),
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    ))
                  ],
                ));
      }
    });
  }

  static void showErrorFromModel(ApiResponse<ErrorEntity>? err) {
    if (err?.data != null) {
      if (err?.data?.validationErrors?.isNotEmpty ?? true) {
        String? validationErrors = err?.data?.validationErrors
            ?.reduce((value, element) => value + '\n' + element);
        Fluttertoast.showToast(msg: validationErrors ?? '');
        return;
      }
      if (err?.data?.message != null) {
        Fluttertoast.showToast(msg: err?.data?.message ?? '');
        return;
      }
    }
    Fluttertoast.showToast(msg: err?.message ?? '');
  }

  static String? getErrorMessageFromModel(ErrorEntity err,
      {bool? withDetails = false}) {
    if (err != null) {
      if (err.validationErrors?.isNotEmpty ?? true) {
        String? validationErrors = err.validationErrors
            ?.reduce((value, element) => value + '\n' + element);
        return validationErrors;
      }
      if (err.message != null) {
        if (withDetails ?? true) {
          return err.message.toString() + '/n' + err.details.toString();
        } else {
          return err.message;
        }
      }
    }
    return err.message;
  }

  static String getFullImageUrl(String fileUrl) {
    return '${AppConfigurations.BaseImagesUrl}$fileUrl';
  }

  static String? getDateWithAppFormat(DateTime? value) =>
      value != null ? AppConfigurations.appDisplayDateFormat.format(value) : "";

  static String? getDateDateOfBirth(DateTime? value) => value != null
      ? AppConfigurations.appDisplayDateOfBirth.format(value)
      : "";

  static String? getDateTimeWithAppFormat(DateTime? value) => value != null
      ? AppConfigurations.appDisplayDateTimeFormat.format(value)
      : "";

  static String? getDateTimeAppointmentApiFormat(DateTime? value) =>
      value != null
          ? AppConfigurations.appointmentApiDateTimeFormat.format(value)
          : "";

  static String? getTimeAppointmentFormat(DateTime? value) => value != null
      ? AppConfigurations.appointmentApiTimeFormat.format(value)
      : "";

  static String? getProfileFormat(DateTime? value) =>
      value != null ? AppConfigurations.profileDateFormat.format(value) : "";

  static String? getAppointmentFormat(DateTime? value) => value != null
      ? AppConfigurations.appointmentDateFormat.format(value)
      : "";

  static String? getAppointmentCreateFormat(DateTime? value) {
    return value != null
        ? AppConfigurations.appointmentCreateApiDateTimeFormat.format(value)
        : "";
  }

  static String? getAppointmentCreateFormatPatient(DateTime? value) {
    return value != null
        ? AppConfigurations.profileDateFormat.format(value)
        : "";
  }

  static String? dayDispalyAppointmentFormat(DateTime? value) {
    return value != null
        ? AppConfigurations.dayDispalyApiDateTimeFormat.format(value)
        : "";
  }

  static String? hourDispalyAppointmentFormat(DateTime? value) {
    return value != null
        ? AppConfigurations.hourDispalyApiDateTimeFormat.format(value)
        : "";
  }

  static FutureOr<Iterable<PlacesSearchResult>> getSuggestionsCallback(
      String value) async {
    var res = (await places.searchByText(
      value,
    ))
        .results;
    return res;
  }

  static FutureOr<Iterable<Prediction>> getPredictionsCallback(
      String value) async {
    var res = (await places.autocomplete(
      value,
      components: [Component(Component.country, "de")],
    ))
        .predictions;
    return res;
  }

  // static FutureOr<Iterable<String>> getSchoolsCallback(
  //     String value) async {
  //   var res = (await places.autocomplete(
  //     value,
  //     components: [Component(Component.country, "de")],
  //   ))
  //       .predictions;
  //   return res;
  // }

  static bool _isTypeCity(AddressComponent result) =>
      result.types.contains('locality') && result.types.contains('political');

  static bool _isTypeZipCode(AddressComponent result) =>
      result.types.contains('postal_code');

  static bool _isTypeStreet(AddressComponent result) =>
      result.types.contains('route');

  static bool _isTypeStreetNum(AddressComponent result) =>
      result.types.contains('street_number');

  static bool _isTypeCountry(AddressComponent result) =>
      result.types.contains('country');

  static AddressComponent? extractCityComponent(
          PlacesDetailsResponse details) =>
      details.result.addressComponents
          .firstWhereOrNull((element) => _isTypeCity(element));

  static AddressComponent? extractZipCodeComponent(
          PlacesDetailsResponse details) =>
      details.result.addressComponents
          .firstWhereOrNull((element) => _isTypeZipCode(element));

  static AddressComponent? extractStreetComponent(
          PlacesDetailsResponse details) =>
      details.result.addressComponents
          .firstWhereOrNull((element) => _isTypeStreet(element));

  static AddressComponent? extractStreetNumberComponent(
          PlacesDetailsResponse details) =>
      details.result.addressComponents
          .firstWhereOrNull((element) => _isTypeStreetNum(element));

  static AddressComponent? extractCountryComponent(
          PlacesDetailsResponse details) =>
      details.result.addressComponents
          .firstWhereOrNull((element) => _isTypeCountry(element));
}
