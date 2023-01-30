import 'package:chegg/core/configurations/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../injection_container.dart';
import '../../l10n/locale_provider.dart';
import '../app/state/appstate.dart';
import '../shared_preferences_items.dart';

class CustomTextField extends StatelessWidget {
  final Key? textKey;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final String? helperText;
  final int? maxLength;
  final bool? isPhone;
  final Color? primaryFieldColor;
  final Color? errorTextColor;
  final Color? textColor;
  final Color? helperTextColor;
  final int? minLines;
  final int? maxLines;
  final double height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? horizontalMargin;
  final double? radius;
  final double? topContentPadding;
  final bool? showCounter;
  final EdgeInsetsGeometry? padding;
  final bool? hasBorder;
  final GestureTapCallback? onTap;
  final bool? justLatinLetters;
  final InputDecoration? inputDecoration;
  final bool readOnly;
  final TextDirection? textAlign;
  final  TextAlign? textAlignHorizntal;
  final Decoration? decoration;
final bool isEditable;

  const CustomTextField(
      {Key? key,
      this.textKey,
      this.readOnly: false,
      required this.controller,
      required this.textInputAction,
      required this.keyboardType,
      required this.focusNode,
      this.decoration,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.obscureText = false,
      this.helperText,
      this.maxLength,
      this.isPhone,
      this.primaryFieldColor,
      this.textColor,
      this.errorTextColor,
      this.minLines,
      this.maxLines,
      required this.height,
      this.fontSize,
      this.fontWeight,
      this.horizontalMargin,
      this.radius,
      this.topContentPadding,
      this.showCounter = true,
      this.padding,
      this.hasBorder: false,
      this.helperTextColor,
      this.onTap,
      this.justLatinLetters = false,
      this.textAlign,
        this.textAlignHorizntal,
        this.isEditable:true,
      this.inputDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextAlign textAlignValue=
        sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
    TextAlign.right:TextAlign.left;
    InputBorder inputBorder = hasBorder != null && !hasBorder!
        ? InputBorder.none
        : OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.transparent),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(33.r),
              topRight: Radius.circular(33.r),
              bottomLeft: Radius.circular(33.r),
              bottomRight: Radius.circular(33.r),
            ),
          );
    return Container(
        height:this.height?? 69.h,
        alignment: Alignment.center,
         // padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration:

        this.decoration??
            BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(33.r),
            topRight: Radius.circular(33.r),
            bottomLeft: Radius.circular(33.r),
            bottomRight: Radius.circular(33.r),
          ),
          color: Color(0xffE8F5ED),
          boxShadow: [
            BoxShadow(
              color: Styles.innerShadowColor2,
              offset: Offset(-0, -7.34),
              blurRadius: 7.34,
              blurStyle: BlurStyle.inner,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0xFFD6E2DB),
              offset: Offset(0, -7.34),
              blurRadius: 7.34,
              blurStyle: BlurStyle.inner,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Styles.dropShadowColor.withOpacity(0.247),
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 46.5,
            ),
          ],
          // color :Color(0xffE8F5ED),
        ),
        child:
Center(child:
        TextFormField(

          enabled: this.isEditable,
          enableInteractiveSelection: true,
          textDirection:  Provider.of<LocaleProvider>(context, listen: false).locale.languageCode=="ar"?
               TextDirection.rtl: TextDirection.ltr
              ,
          onTap: onTap,
          readOnly: this.readOnly,
          autocorrect: false,
          cursorColor: this.textColor ?? this.primaryFieldColor,
          textAlignVertical: TextAlignVertical.center,

          style:   TextStyle(
            color: this.textColor ?? this.primaryFieldColor,
            fontWeight:
                this.fontWeight != null ? this.fontWeight : FontWeight.w300,
            fontSize:
                this.fontSize == null ? ScreenUtil().setSp(11) : this.fontSize,
          ),
          key: textKey,
          maxLength: maxLength,
          // expands: true,
          // maxLines: maxLines == null ? null : maxLines,
          // minLines: minLines == null ? null : minLines,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          focusNode: focusNode,
          toolbarOptions: ToolbarOptions(
              copy: true, paste: true, cut: true, selectAll: true),

          textAlign:this.textAlignHorizntal??textAlignValue,
          decoration:this.inputDecoration??
          InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: 20.w),
                child: this.suffixIcon),
            border: inputBorder,
            focusedBorder: inputBorder,
            errorBorder: inputBorder,
            disabledBorder: inputBorder,
            enabledBorder: inputBorder,
            focusedErrorBorder: inputBorder,
            counterStyle: TextStyle(height: double.minPositive),
            counter: (showCounter ?? false)
                ? SizedBox(
                    height: 0,
                    width: 0,
                  )
                : Text(''),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            hintStyle: TextStyle(
              color: helperTextColor == null
                  ? this.textColor
                  : this.helperTextColor,
              fontSize: ScreenUtil().setSp(16),
            ),
            hintText: helperText,
            errorStyle: TextStyle(
              color: this.errorTextColor ?? Colors.red,
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.disabled,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        )));
  }
}
