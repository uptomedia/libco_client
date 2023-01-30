import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/ui/widget/LILA/custom_text.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final double width;
  final double height;
  final String message;
  final Function func;

  const ErrorWidgetScreen(
      {required this.message,
      this.width = 250,
    this.height = 300,
    required this.func,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.98,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.05),
      child: Center(
        child: Container(
            width: width * 0.6,
            height: height * 0.4,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              gradient: LinearGradient(
//begin: Alignment.center,
                //    end: Alignment.bottomCenter,
                colors: [
                  Styles.ColorLiteGray1,
                  Styles.ColorLiteGray2],
              ),
              boxShadow: [
                BoxShadow(
                  color: Styles.ColorLiteGray, //.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  //  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: height*0.2,),
                CustomText(
                  text: message,
                  style: Styles.fontStyle.copyWith(
                      fontFamily: Styles.FontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: Styles.fontSize14,
                      color: Styles.FontColorBlack),
                  textAlign: TextAlign.start,
                  alignmentDirectional: AlignmentDirectional.center,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: S.of(context).reload,
                  style: Styles.fontStyle.copyWith(
                      fontFamily: Styles.FontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: Styles.fontSize14,
                      color: Styles.FontColorWhite),
                  textAlign: TextAlign.center,
                  color: Styles.FontColorBlueTurquoise,
                  fillColor: Styles.FontColorBlueTurquoise,
                  width: width * 0.4,
                  height: height * 0.1,
                  alignmentDirectional: AlignmentDirectional.center,
                  onPressed: func,
                ),
                // SizedBox(height: height*0.05,),
              ],
            )),
      ),
    );
  }
}
