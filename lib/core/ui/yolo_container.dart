import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YoloContainer extends AppStatelessWidget {
  final Widget? child;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? width;
  final double? radius;

  YoloContainer(
      {this.child,
      this.verticalPadding,
      this.horizontalPadding,
      this.width,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      padding: EdgeInsets.symmetric(
          vertical: this.verticalPadding ?? CommonSizes.SMALL_LAYOUT_W_GAP.h,
          horizontal:
              this.horizontalPadding ?? CommonSizes.SMALL_LAYOUT_W_GAP.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.radius ?? 60.r),
          boxShadow: [
            BoxShadow(
                color: Styles.shadowColor, blurRadius: 4, spreadRadius: -2)
          ],
          color: Styles.colorTertiary),
      child: this.child ?? SizedBox(),
    );
  }
}
