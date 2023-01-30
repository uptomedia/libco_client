import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CheggContainer extends AppStatelessWidget {
  final Widget? child;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? width;
  final double? radius;
  final double? height;
  final Decoration? decoration;
  final double? margin;

  CheggContainer(
      {this.child,
      this.margin,
      this.verticalPadding,
      this.horizontalPadding,
      this.width,
      this.height,
      this.decoration,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      // margin: EdgeInsets.symmetric(horizontal: this.margin?? CommonSizes.SMALL_LAYOUT_W_GAP.h),
      padding: EdgeInsets.symmetric(
          vertical: this.verticalPadding ?? 0,
          horizontal: this.horizontalPadding ?? 0),
      decoration: this.decoration ??
          BoxDecoration(

              // borderRadius: BorderRadius.circular(this.radius ?? 60.r),
              // boxShadow: [
              //   BoxShadow(
              //       color: Styles.shadowColor, blurRadius: 4, spreadRadius: -2)
              // ],
              color: Styles.colorPrimary),

      child: this.child ?? SizedBox(),
    );
  }
}
