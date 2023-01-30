import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

class Styles {
  /// App Settings

  //Color
  static Color get colorPrimary => Color(0xFF21A86E);

  static Color get colorSecondary => Color(0xFF72BE44);

  static Color get textWhiteColor => Color(0xFFFFFFFF);

  static Color get colorTertiary => Color(0xFFFFFFFF);

  static Color get colorBackground => Color(0xFFE8F5ED);

  static Color get textBlackColor => Color(0xFF1F1F1F);

  static Color get textBlackDarkColor => Color(0xFF000000);

  static Color get dropShadowColor => Color(0xFF2E312F);

  static Color get dropShadowColorNav => Color(0xFF0A2A17);

  static Color get innerShadowColor => Color(0xFFD6E2DB);

  static Color get innerShadowColor2 => Color(0xFFF6FFFC);

  static Color get innerShadowColorNavBarIcon => Color(0xFF2FC26A);

  static Color get innerShadowColorNavBarIcon2 => Color(0xFF36DE79);

  static Color get innerShadowColorNavBar2 => Color(0xFFF6FFFB);

  //font
  static double get fontSize0 => 80.0.sp; //20

  static double get fontSize01 => 65.0.sp; //30

  static double get fontSize1 => 55.0.sp; //20

  static double get fontSize2 => 50.0.sp; //18

  static double get fontSize3 => 45.0.sp; //16

  static double get fontSize4 => 40.0.sp; //14

  static double get fontSize5 => 22.0.sp; //12

  static double get fontSize6 => 18.0.sp; //10
  static double get fontSize7 => 16.0.sp; //10
  static double get fontSize24 => 24.0.sp; //24
  static double get fontSize32 => 32.0.sp; //24

  /// font
  static const FontFamily = 'Lato';
  static const FontFamilyBlack = 'Lato-Black';
  static const FontFamilyBold = 'Lato-Bold';
  static const FontFamilySemiBold = 'Lato-SemiBold';
  static const FontFamilyLight = 'Lato-Light';
  static const FontFamilyPoppinsMedium = 'Lato-Medium';

  static double fontSize8 = 8;
  static double fontSize10 = 10;
  static double fontSize11 = 11;
  static double fontSize12 = 12;
  static double fontSize13 = 13;
  static double fontSize14 = 14;
  static double fontSize15 = 15;
  static double fontSize16 = 16;
  static double fontSize17 = 17;
  static double fontSize18 = 18;
  static double fontSize19 = 19;
  static double fontSize20 = 20;
  static double fontSize23 = 23;
  static double fontSize25 = 25;
  static double fontSize26 = 25;
  static double fontSize30 = 30;
  static double fontSize35 = 35;
  static double fontSize40 = 40;
  static double fontSize88 = 88;

  static double fontSizeCustom(double size) => size;

  static const FontColorWhite = Color(0xFFFFFFFF);
  static const FontColorGray = Color(0xFFBCBCBC);
  static const FontColorDarkGray = Color(0xFF8D9595);
  static const FontColorLiteGray = Color(0xFFE8E8E8);
  static const FontColorLiteGraycallendar = Color(0xFFEEEEEE);
  static const FontColorDarkGray1 = Color(0xFF9A9A9A);
  static const FontColorLiteGray2 = Color.fromRGBO(198, 198, 198, 1.0);

  static const FontColorLiteGrayClendar = Color.fromRGBO(222, 222, 222, 1);

//Color(0xFFDEDEDE);
  static const FontColorLiteGray3 = Color(0xFFF3F3F3);
  static const OccpanyColorFree = Color(0xFFA0A0A0);

  static const FontColorBlack = Color(0xFF494949);
  static const ColorYellow = Color(0xFFFFDFA0);
  static const ColorDarkYellow = Color(0xFFC0C48A);
  static const FontColorNiagara = Color(0xFF0FB0A2);
  static const FontColorOrange = Color(0xFFE8833B);
  static const FontColorOrangeLite = Color(0xFFFFA337);
  static const FontColorYellow = Color(0xFFEAC170);
  static const FontColorBlueTurquoise = Color(0xFFE3E935);
  static const FontColorLiteBlack = Color(0xFF707070);
  static const FontColorLiteBlack2 = Color(0xFF474C4E);
  static const FontColorLiteBlack3 = Color(0xFF636363);
  static const FontColorLiteBlack4 = Color(0xFF484D4D);
  static const FontColorBlackDark = Color(0xFF000000);
  static const FontCalendarTodayBlack = Color(0xFF484D4D);
  static const FontCalendarTrailingBlack = Color(0xFFA0A0A0);
  static const ColorCalendarPan = Color(0xFFC4C4C4);

  static const FontColorBlueTurquoise1 = Color(0xFF0990AD);
  static const FontColorFiterInactive = Color(0xFF807E7E);

  static TextStyle get fontStyle => TextStyle(fontFamily: "Lato");

  static get mediumFontStyle =>
      fontStyle.copyWith(fontFamily: "Lato", fontWeight: FontWeight.w500);

  static get semiBoldFontStyle =>
      fontStyle.copyWith(fontFamily: "Lato", fontWeight: FontWeight.w600);

  static get boldFontStyle =>
      fontStyle.copyWith(fontFamily: "Lato", fontWeight: FontWeight.w700);

  static InputDecoration formInputDecoration = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: Colors.white);

  static BoxDecoration decotrationBoxStyled({
    double radius = 0,
    Color backgroundColor = const Color(0xffE8F5ED),
    Offset dropOffset = const Offset(0, 27.6),
    double dropspreadRadius = 0,
    double dropblurRadius = 55.2,
    Color dropShadawColor = const Color(0xFF2E312F),
    Offset innerOffset1 = const Offset(0, -8.65),
    double innerspreadRadius1 = 0,
    double innerblurRadius1 = 8.65,
    Color innerShadawColor1 = const Color(0xFFD6E2DB),
    Offset innerOffset2 = const Offset(-0, 8.65),
    double innerspreadRadius2 = 0,
    double innerblurRadius2 = 8.65,
    Color innerShadawColor2 = const Color(0xFFF6FFFC),
  }) =>
      BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
          bottomLeft: Radius.circular(radius.r),
          bottomRight: Radius.circular(radius.r),
        ),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: innerShadawColor2,
            offset: innerOffset2,
            blurRadius: innerblurRadius2,
            blurStyle: BlurStyle.inner,
            spreadRadius: innerspreadRadius2,
          ),
          BoxShadow(
            color: innerShadawColor1,
            offset: innerOffset1,
            blurRadius: innerblurRadius1,
            blurStyle: BlurStyle.inner,
            spreadRadius: innerspreadRadius1,
          ),
          BoxShadow(
            color: dropShadawColor,
            offset: dropOffset,
            spreadRadius: dropspreadRadius,
            blurRadius: dropblurRadius,
          ),
        ],
        // color :Color(0xffE8F5ED),
      );

  static BoxDecoration decotrationBoxStyledWithGradient({
    double radius = 0,
    Color backgroundColor1 = const Color(0xffE8F5ED),
    Color backgroundColor2 = const Color(0xffE8F5ED),
    Offset dropOffset = const Offset(0, 27.6),
    double dropspreadRadius = 0,
    double dropblurRadius = 55.2,
    Color dropShadawColor = const Color(0xFF2E312F),
    Offset innerOffset1 = const Offset(0, -8.65),
    double innerspreadRadius1 = 0,
    double innerblurRadius1 = 8.65,
    Color innerShadawColor1 = const Color(0xFFD6E2DB),
    Offset innerOffset2 = const Offset(-0, 8.65),
    double innerspreadRadius2 = 0,
    double innerblurRadius2 = 8.65,
    Color innerShadawColor2 = const Color(0xFFF6FFFC),
  }) =>
      BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius.r),
          topRight: Radius.circular(radius.r),
          bottomLeft: Radius.circular(radius.r),
          bottomRight: Radius.circular(radius.r),
        ),
        gradient: LinearGradient(colors: [backgroundColor1, backgroundColor2]),

        boxShadow: [
          BoxShadow(
            color: dropShadawColor,
            offset: dropOffset,
            spreadRadius: dropspreadRadius,
            blurRadius: dropblurRadius,
          ),
          BoxShadow(
            color: innerShadawColor1,
            offset: innerOffset1,
            blurRadius: innerblurRadius1,
            blurStyle: BlurStyle.inner,
            spreadRadius: innerspreadRadius1,
          ),
          BoxShadow(
            color: innerShadawColor2,
            offset: innerOffset2,
            blurRadius: innerblurRadius2,
            blurStyle: BlurStyle.inner,
            spreadRadius: innerspreadRadius2,
          ),
        ],
        // color :Color(0xffE8F5ED),
      );

  static InputDecoration borderlessRoundedFieldDecoration(
          {double radius = 40}) =>
      formInputDecoration.copyWith(
          border: InputBorder.none,
          focusedBorder: roundedTransparentBorder(radius: radius),
          enabledBorder: roundedTransparentBorder(radius: radius),
          errorBorder: roundedTransparentBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedTransparentBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);

  static InputDecoration borderedRoundedFieldDecoration({double radius = 40}) =>
      formInputDecoration.copyWith(
          border: roundedOutlineInputBorder(radius: radius),
          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);

  static InputBorder roundedTransparentBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(radius),
      );

  static InputBorder roundedOutlineInputBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: Styles.colorPrimary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      );

  static BoxDecoration roundedOutlineDecoration(
          {double radius = 40, BoxBorder? border}) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: border ?? Border.all(color: ColorBlack),
        // color: Styles.colorPrimary,
      );
  static BoxDecoration roundedDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(23.r),
      ),
      boxShadow: [
        BoxShadow(
          color: Styles.shadowColor.withOpacity(0.08),
          blurRadius: 6,
          offset: Offset(3, 3), // changes position of shadow
        )
      ],
      border: Border.all(color: colorPrimary),
      color: colorPrimary
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );

  static BoxDecoration noBorderDecoration({double radius = 40}) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: Colors.transparent,
      );

  static TextStyle textStyle = fontStyle.copyWith(
      fontSize: fontSize30,
      fontWeight: FontWeight.w700,
      fontFamily: Styles.FontFamilyBold,
      color: FontColorBlackDark,
      letterSpacing: 0,
      height: 1);

  static BoxDecoration shadowAnswerDecoration({double radius = 40}) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(color: colorPrimary),
        // color: Styles.colorPrimary,
      );

  static const ColorGradientbtn = Color(0xFF53BFD7);
  static const ColorGradientbtnEnd = Color(0xFF13A7C8);
  static const ColorNoGradientbtn = Color(0xFFB8D4DB);
  static const ColorNoGradientbtnEnd = Color(0xFF91ABB1);

  static BoxDecoration btnDecoration({double radius = 40}) => BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [
            ColorGradientbtn.withOpacity(1),
            ColorGradientbtnEnd.withOpacity(1),
          ], // red
          stops: [0, 1],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        // color: Styles.colorPrimary,
      );

  static BoxDecoration btnNoDecoration({double radius = 40}) => BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [
            ColorNoGradientbtn.withOpacity(1),
            ColorNoGradientbtnEnd.withOpacity(1),
          ], // red
          stops: [0, 1],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(color: colorPrimary),
        // color: Styles.colorPrimary,
      );

  static BoxDecoration searchFieldDecoration({double radius = 25}) =>
      BoxDecoration(
        boxShadow: defaultBoxShadow(),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [], // red
          stops: [0.5, 0.8],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(color: colorPrimary),
        // color: Styles.colorPrimary,
      );

  static BoxDecoration transparentDecoration({double radius = 40}) =>
      BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     // color: Styles.CheggBlackShadow,
          //     blurRadius: 1,
          //   ),
          // ],
          // gradient:  LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment
          //       .bottomCenter, // 10% of the width, so there are ten blinds.
          //   colors: [
          //     CheggGradientStart.withOpacity(0.8),
          //     CheggGradientEnd.withOpacity(0.9),
          //   ], // red
          //   stops: [0, 1], ),
          // borderRadius: BorderRadius.all(
          //   Radius.circular(radius),
          // ),
          // border: Border.all(color: CheggGradientEnd),
          // // color: Styles.colorPrimary,
          );

  ///
  ///
  /// Colors

  static const ColorGray = Color(0xFFCBCFD3);

  static const ColorBlack = Color(0xFF424243);
  static const ColorWhite = Color(0xFFFFFFFF);
  static const ColorLiteWhiteBackground = Color(0xFFF6F6F6);
  static const ColorWhiteBackground = Color(0xFFFFFFFF);
  static const ColorLiteGray = Color(0xFFECECEC);
  static const ColorLiteGray1 =
  Color.fromRGBO(245, 245, 245, 1); //Color(0xF5F5FFFF);
  static const ColorLiteGray2 = Color(0xFFE9E9E9); //timeline background
  static const ColorLiteGray3 = Color(0xFFE5E5E5); // background
  static const ColorLiteBlack = Color(0xFF707070);
  static const ColorLiteGray4 = Color(0xFFDEDEDE);
  static const ColorLiteGray6 = Color(0xFFEEEEEE); //header
  static const ColorGray5 = Color(0xFF565656);
  static const ColorGrayPayementStatus = Color(0xFF696969);
  static const ColorTextFieldBackground = Color(0xFFFFFFFF);

  static const ColorBlueTurquoiseLite = Color(0xFF10B6C0);
  static const ColorOrangeLite = Color(0xFFFFA337);
  static const ColorMenuDivider = Color.fromRGBO(83, 191, 215, 0.19);
  static const ColorBorderImage = Color(0xFF53BFD7);
  static const ColorblueTakephoto = Color(0xFF13A7C8);

//// Appointmet Status Colors
  static const ColorOnHoldAppointment =
      Color(0xFF7C8080); //appointment status onhold
  static const ColorUpcomingAppointment =
      Color(0xFF13A7C8); //appointment status upcoming
  static const ColorCanceledAppointment =
      Color(0xFFE91717); //appointment status canceled
  static const ColorWaitingAppointment =
      Color(0xFF101820); //  Color(0xFF565656); //appointment status waiting
  static const ColorInprogressAppointment =
      Color(0xFF221551); //appointment status inprogress
  static const ColorFinishedAppointment =
  Color(0xFF34CE0E); //appointment status finished

  static const ColorConfirmedAppointment =
  Color(0xFFF09491); //Colors.deepPurpleAccent;
  ///

  ///gradient color
  static const ColorBlueTurquoise = Color(0xFFE3E935);
  static const ColorPurple = Color(0xFF312277);
  static const ColorPurpleEnd = Color(0xFFf1d7d8);

  //  Color.fromRGBO(40, 30, 119, 255),
  // Color.fromRGBO(185,143,165,255)
  static const ColorBlueTurquoiseEnd = Color(0xFFE3E935);
  static const ColorBlueTurquoiseEnd2 = Color(0xFFE3E935);
  static const ColorCalenderTrailing = Color(0xFFA0A0A0);

  ///
  /// Bottom navigation
  static TextStyle bottomNavigationStyle = TextStyle(color: colorPrimary);
  static Color bottomNavigationSelectedIconColor = colorPrimary;
  static const BottomNavigationUnselectedIconColor = ColorGray;
  static const splashBackgroundColor = Color(0xFFE3E935);

  //shadow
  static Color shadowColor = Colors.grey.withOpacity(0.2);

  //AppBar

  static var bottomNavigationSelectedStyle = fontStyle.copyWith(
      fontFamily: "Lato", color: colorPrimary, fontSize: Styles.fontSize13);
  static var bottomNavigationUnselectedStyle = fontStyle.copyWith(
      fontFamily: "Lato", color: FontColorBlack, fontSize: Styles.fontSize13);

  static var cellTodayCalenderDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(0),
    ),
    color: Styles.FontColorBlueTurquoise,
  );
  static var cellCalenderDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
      color: Styles.ColorWhite);
}

abstract class CommonSizes {
  /// Mozzaik application sizes
  static const TINIEST_LAYOUT_W_GAP = 5.0;
  static const TINY_LAYOUT_W_GAP = 10.0;
  static const SMALL_LAYOUT_W_GAP = 25.0;
  static const MED_LAYOUT_W_GAP = 50.0;
  static const BIG_LAYOUT_W_GAP = 75.0;
  static const BIGGER_LAYOUT_W_GAP = 100.0;
  static const BIGGEST_LAYOUT_W_GAP = 125.0;
  static const BORDER_RADIUS_STANDARD = 15.0;
  static const BORDER_RADIUS_CORNERS_BIG = 18.0;

  static final appBarHeight = 60.h;

  static final navBarHeight = 50.h;

  /// --------------- ///
  static final vSmallestSpace5v = SizedBox(height: 5.h);
  static final vSmallestSpace = SizedBox(height: 10.h);
  static final vSmallerSpace = SizedBox(height: 20.h);
  static final vSmallSpace = SizedBox(height: 30.h);
  static final vBigSpace = SizedBox(height: 40.h);
  static final vBiggerSpace = SizedBox(height: 50.h);
  static final vBiggestSpace = SizedBox(height: 60.h);
  static final vLargeSpace = SizedBox(height: 70.h);
  static final vLargerSpace = SizedBox(height: 80.h);
  static final vLargestSpace = SizedBox(height: 90.h);
  static final vHugeSpace = SizedBox(height: 100.h);

  static vCustomSpace(double size) => SizedBox(height: size.h);

  static final hSmallestSpace = SizedBox(width: 10.w);
  static final hSmallerSpace = SizedBox(width: 20.w);
  static final hSmallSpace = SizedBox(width: 30.w);
  static final hBigSpace = SizedBox(width: 40.w);
  static final hBiggerSpace = SizedBox(width: 50.w);
  static final hBiggestSpace = SizedBox(width: 60.w);
  static final hLargeSpace = SizedBox(width: 70.w);
  static final hLargerSpace = SizedBox(width: 80.w);
  static final hLargestSpace = SizedBox(width: 90.w);
  static final hHugeSpace = SizedBox(width: 100.w);

  static const divider = const Divider(thickness: 10);
}
