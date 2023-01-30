import 'dart:async';

import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:google_maps_webservice/geocoding.dart';

class AutoCompleteWidget<T> extends StatelessWidget {
  // final controller;
  final FutureOr<Iterable<T>> Function(String) suggestionsCallback;
  final void Function(String?)? onSaved;

  // final Color primaryFieldColor;

  final Key? textKey;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
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
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? horizontalMargin;
  final double radius;
  final double topContentPadding;
  final bool? showCounter;
  final EdgeInsetsGeometry? padding;
  final bool hasBorder;
  final GestureTapCallback? onTap;
  final bool? justLatinLetters;
  final String? errorText;
  final bool isFormField;
  final double? maxHeight;
  final bool up;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final Color? borderColor;
  final double? suggestionsBoxVerticalOffset;
  final InputBorder? borderRadius;
  final void Function(T)? onSuggestionSelected;

  final Widget Function(BuildContext, T) itemBuilder;

  final SuggestionsBoxController? suggestionsBoxController;

  const AutoCompleteWidget(
      {this.controller,
      required this.suggestionsCallback,
      this.onSaved,
      this.primaryFieldColor,
      this.textKey,
      this.textInputAction,
      this.keyboardType,
      this.focusNode,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.obscureText,
      this.helperText,
      this.maxLength,
      this.isPhone,
      this.errorTextColor,
      this.textColor,
      this.helperTextColor,
      this.minLines,
      this.maxLines,
      this.height,
      this.fontSize,
      this.fontWeight,
      this.horizontalMargin,
      this.radius = 25.0,
      this.topContentPadding = 0,
      this.showCounter,
      this.padding,
      this.hasBorder = false,
      this.onTap,
      this.justLatinLetters,
      this.errorText,
      required this.itemBuilder,
      this.onSuggestionSelected,
      this.suggestionsBoxController,
      this.isFormField = false,
      this.maxHeight,
      this.up = false,
      this.labelStyle,
      this.helperStyle,
      this.errorStyle,
      this.borderColor,
      this.borderRadius,
      this.suggestionsBoxVerticalOffset});

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = !hasBorder
        ? InputBorder.none
        : OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor ?? primaryFieldColor ?? Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          );

    if (this.isFormField)
      return TypeAheadFormField<T>(
        hideOnError: true,
        suggestionsBoxController: suggestionsBoxController,
        key: textKey,
        noItemsFoundBuilder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              S.of(context).noItemsFound,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).disabledColor, fontSize: 18.0),
            ),
          );
        },
        autovalidateMode: AutovalidateMode.always,
        textFieldConfiguration: TextFieldConfiguration(
            onChanged: onChanged,
            controller: controller,
            focusNode: this.focusNode,
            decoration: InputDecoration(
              fillColor: primaryFieldColor,
              filled: true,
              suffixIcon: this.suffixIcon,
              prefixIcon: this.prefixIcon,
              border: this.borderRadius ?? inputBorder,
              contentPadding: EdgeInsetsDirectional.only(
                  top: 20.h, start: CommonSizes.BIG_LAYOUT_W_GAP.w),
              focusedBorder: this.borderRadius ?? inputBorder,
              errorBorder: this.borderRadius ?? inputBorder,
              disabledBorder: this.borderRadius ?? inputBorder,
              enabledBorder: this.borderRadius ?? inputBorder,
              focusedErrorBorder: this.borderRadius ?? inputBorder,
              errorText: "",
              isDense: false,
              hintText: helperText,
              labelStyle: this.labelStyle,
              hintStyle: helperStyle,
              errorStyle: errorStyle,
            )),
        suggestionsCallback: suggestionsCallback,
        debounceDuration: Duration(milliseconds: 500),
        itemBuilder: itemBuilder,
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: onSuggestionSelected ?? (T) {},
        direction: this.up ? AxisDirection.up : AxisDirection.down,
        validator: this.validator,
        onSaved: onSaved ?? (String? d) {},
        suggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset ?? 15.h,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
            constraints: BoxConstraints(maxHeight: this.maxHeight ?? 300.h)),
      );
    return TypeAheadField(
      hideOnError: true,
      noItemsFoundBuilder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            S.of(context).noItemsFound,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).disabledColor, fontSize: 18.0),
          ),
        );
      },
      suggestionsBoxController: suggestionsBoxController,
      key: textKey,
      textFieldConfiguration: TextFieldConfiguration(
          onChanged: onChanged,
          controller: controller,
          focusNode: this.focusNode,
          decoration: InputDecoration(
            fillColor: primaryFieldColor,
            filled: true,
            suffixIcon: this.suffixIcon,
            prefixIcon: this.prefixIcon,
            border: inputBorder,
            focusedBorder: inputBorder,
            errorBorder: inputBorder,
            disabledBorder: inputBorder,
            enabledBorder: inputBorder,
            focusedErrorBorder: inputBorder,
            errorText: errorText,
            isDense: false,
            hintText: helperText,
            labelStyle: this.labelStyle,
            hintStyle: helperStyle,
            errorStyle: errorStyle,
          )),
      suggestionsCallback: suggestionsCallback,
      debounceDuration: Duration(milliseconds: 500),
      itemBuilder: itemBuilder,
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: onSuggestionSelected ?? (T) {},
      suggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset ?? 15.h,
      direction: this.up ? AxisDirection.up : AxisDirection.down,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          constraints: BoxConstraints(maxHeight: this.maxHeight ?? 300.h)),
    );
  }
}
