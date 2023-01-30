import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheggDivider extends AppStatelessWidget {
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? width;
  final double? height;
  final Color? color;
  final double? hMargin;

  CheggDivider({
    this.hMargin,
    this.verticalPadding,
    this.horizontalPadding,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: EdgeInsets.symmetric(
          horizontal: this.hMargin ?? 0 + CommonSizes.SMALL_LAYOUT_W_GAP.h),
      padding: EdgeInsets.symmetric(
          vertical: this.verticalPadding ?? CommonSizes.SMALL_LAYOUT_W_GAP.h,
          horizontal:
              this.horizontalPadding ?? CommonSizes.SMALL_LAYOUT_W_GAP.w),
      color: this.color ?? Styles.colorPrimary,
    );
  }
}
