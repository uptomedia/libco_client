import 'package:chegg/core/utils.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';

import 'configurations/assets.dart';
import 'configurations/styles.dart';

class AppHelperFunctions {
  /// boolean to check if application in release or debug
  static bool get inReleaseMode => Foundation.kReleaseMode;

  /// check if instance is a sub type from type T
  static bool checkIfIsSubType<T>(instance) =>
      instance is T && instance.runtimeType != T;

  /// check if instance is a sub type from type T or it is same type
  static bool checkIfSubOrSameType<T>(instance) =>
      instance is T && instance.runtimeType != T || instance is T;

  static getImagePathStatusFunc(int status) {
    // switch (status) {
    //   case 0:
    //     return Assets.PNG_OnhodApointmentCalender; //OnHold
    //   case 1:
    //     return Assets.PNG_UpcomingApointmentCalender; //Upcoming
    //   case 2:
    //     return Assets.PNG_CanceledApointmentCalender; //Canceled
    //   case 3:
    //     return Assets.PNG_FinishedApointmentCalender; //Finished
    //   case 4:
    //     return Assets.PNG_InprogressApointmentCalender; //Inprogress
    //   case 5:
    //     return Assets.PNG_WaitingApointmentCalender; //Waiting
    //   case 6:
    //     return Assets.PNG_ConfirmedApointmentCalender;
    //   default:
    //     {
    //       return Assets.PNG_OnhodApointmentCalender;
    //     }
    // }
  }

  static String getPaymentStatusName(int index) {
    switch (index) {
      case 1:
        return "not paid";
        break;
      case 2:
        return "partially paid";
        break;
      case 3:
        return "paid";
        break;
      default:
        {
          return " not paid";
        }
    }
  }

  static getStylesPayment(int status) {
    switch (status) {
      case 1:
        return Colors.red; //OnHold
      case 3:
        return Colors.green; //Upcoming
      case 2:
        return Styles.ColorBlueTurquoise; //Canceled
      default:
        {
          return Styles.FontColorBlack;
        }
    }
  }

  static getStylesStatusButton(int status) {
    switch (status) {
      case 1:
        return Styles.ColorOnHoldAppointment; //OnHold
      case 2:
        return Styles.ColorUpcomingAppointment; //Upcoming
      case 3:
        return Styles.ColorCanceledAppointment; //Canceled
      case 4:
        return Styles.ColorFinishedAppointment; //Finished
      case 5:
        return Styles.ColorInprogressAppointment.withOpacity(0.75); //Inprogress
      case 6:
        return Styles.ColorWaitingAppointment.withOpacity(0.75); //Waiting
      case 7:
        return Styles.ColorConfirmedAppointment;
      default:
        {
          return Styles.ColorWhite;
        }
    }
  }

  static getFontColorsStatusButton(int status) {
    switch (status) {
      case 1:
        return Styles.FontColorBlackDark; //OnHold
      case 2:
        return Styles.FontColorBlackDark; //Upcoming
      case 3:
        return Styles.FontColorBlackDark; //Canceled
      case 4:
        return Styles.FontColorBlackDark; //Finished
      case 5:
        return Styles.FontColorBlackDark; //Inprogress
      case 6:
        return Styles.FontColorBlackDark; //Waiting
      case 7:
        return Styles.FontColorBlackDark;
      default:
        {
          return Styles.FontColorBlackDark;
        }
    }
  }

  static getStylesStatusHexColor(int status) {
    switch (status) {
      case 1:
        return "#7C8080"; //OnHold
      case 2:
        return "#13A7C8"; //Upcoming
      case 3:
        return "#E91717"; //Canceled
      case 4:
        return "#34CE0E"; //Finished
      case 5:
        return "#221551"; //Inprogress
      case 6:
        return "#101820"; //Waiting
      case 7:
        return "#F09491";
      default:
        {
          return "#9E9E9EFF";
        }
    }
  }

  static getStylesImageButton(int status) {
    switch (status) {
      case 1:
        return Styles.ColorCanceledAppointment;

      case 2:
        return Styles.ColorUpcomingAppointment; //Upcoming
      case 3:
        return Styles.ColorOnHoldAppointment; //OnHold
//Canceled
      //Waiting
      default:
        {
          return Styles.ColorWhite;
        }
    }
  }

  static Color hexToColor(String code) {
    try {
      if (code == "") {
        return Colors.grey;
      } else {
        return new Color(
            int.tryParse(code.substring(1, 7), radix: 16)! + 0xFF000000);
      }
    } catch (e) {
      print(e);
      return Colors.grey;
    }
    return Colors.grey;
  }

  static String getDateProfile(String s) {
    var offset = DateTime.now().timeZoneOffset;
    DateTime date = DateTime.tryParse(s) ?? DateTime.now();

    date = offset.isNegative ? date.subtract(offset) : date.add(offset);
    return Utils.getProfileFormat(date).toString();
  }

  static buildprofilePhotoWithSize(String img, double size,
      {color: Styles.FontColorBlueTurquoise}) {
    return img.contains("http") == true
        ? Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(size)),
              border: Border.all(
                color: color,
                width: 1.0,
              ),
            ),
          )
        : img.contains("assets") == true
            ? Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size)),
                  border: Border.all(
                    color: color,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                    radius: size,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      img,
                    )

                    //NetworkImage(widget.imageUrl)
                    ))
            : Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size)),
                  border: Border.all(
                    color: color,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                    radius: size,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      Assets.PNG_NoImage,
                    )));
  }

  static buildCardPhotoWithSize(String img, double size,
      {color: Styles.FontColorBlueTurquoise}) {
    return img.contains("http") == true
        ? Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(size)),
              border: Border.all(
                color: color,
                width: 1.0,
              ),
            ),
          )
        : img.contains("assets") == true
            ? Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size)),
                  border: Border.all(
                    color: color,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                    radius: size,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      img,
                    )

                    //NetworkImage(widget.imageUrl)
                    ))
            : Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size)),
                  border: Border.all(
                    color: color,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                    radius: size,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      Assets.PNG_NoImage,
                    )));
  }
}
