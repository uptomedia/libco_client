import 'package:chegg/core/configurations/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Color color;
  final Color fillColor;
  final double width;
  final double height;
  final Function onPressed;
  final double raduis;
  final Color gradienStart;
  final Color gradienEnd;
  final bool withGradiant;
  final bool withIcon;
  final String iconPath;
  final AlignmentDirectional alignmentDirectional;
  final Color iconColor;

  const CustomButton(
      {required this.text,
      required this.style,
      required this.textAlign,
      required this.height,
      this.withIcon = false,
      this.withGradiant = false,
      this.iconPath = "",
      required this.color,
      required this.fillColor,
      required this.width,
      required this.onPressed,
      required this.alignmentDirectional,
      this.raduis = 30,
      this.iconColor = const Color(0xFF484d4d),
      this.gradienStart = Styles.ColorBlueTurquoise,
      this.gradienEnd = Styles.ColorBlueTurquoiseEnd,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: withIcon
          ? Container(
              width: width,
              height: height,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              decoration: withGradiant == true
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(raduis),
                      ),
                      border: Border.all(color: color),
                      gradient: LinearGradient(
                        colors: [gradienEnd, gradienStart],
                      ),

                      // color:fillColor,
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(raduis),
                      ),
                      border: Border.all(color: color),
                      color: fillColor,
                    ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      iconPath,
                      color: iconColor,
                    ),
                    CustomText(
                      text: text,
                      style: style,
                      textAlign: TextAlign.center,
                      alignmentDirectional: alignmentDirectional,
                    ),
                  ]))
          : Container(
              width: width,
              height: height,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              decoration: withGradiant == true
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(raduis),
                      ),
                      border: Border.all(color: color),
                      gradient: LinearGradient(
                        colors: [gradienEnd, gradienStart],
                      ),

                      // color:fillColor,
                    )
                  :   BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(33.r),
                  topRight: Radius.circular(33.r),
                  bottomLeft: Radius.circular(33.r),
                  bottomRight: Radius.circular(33.r),
                ),
                boxShadow : [
                  BoxShadow(
                      color:Color(0xff072216).withOpacity(0.16),
                      offset: Offset(0,23.r),
                      blurRadius: 46.5.r,
                  ),
                  BoxShadow(
                      color:Color(0xff1F9F68),
                      offset: Offset(0,-6.21.r),
                      blurRadius: 6.21.r,
                      blurStyle:BlurStyle.inner
                  ) ,

                  BoxShadow(
                      color:Color(0xff22AF73),
                      offset: Offset(0,6.21.r),
                      blurRadius: 6.21.r,
                      blurStyle:BlurStyle.inner

                  )
                ],
                color :Styles.colorPrimary,
              ),
              child: Center(
                child: CustomText(
                  text: text,
                  style: style,
                  textAlign: TextAlign.center,
                  alignmentDirectional: alignmentDirectional,
                ),
              )),
    );
  }
}
