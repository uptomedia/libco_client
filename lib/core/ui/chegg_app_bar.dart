import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheggAppBar extends AppStatelessWidget {
  final String title;
  final List<Widget> tail;
  final Function? onPressed;
  final bool withBack;

  CheggAppBar({
    this.title = "",
    this.onPressed,
    required this.tail,
    this.withBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: CommonSizes.appBarHeight,
      // decoration: BoxDecoration(
      //   color: Styles.colorAppBar,
      //   gradient:  LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment
      //         .bottomCenter, // 10% of the width, so there are ten blinds.
      //     colors: [
      //       Styles.CheggGradientStart.withOpacity(1),
      //       Styles.CheggGradientEnd.withOpacity(1),
      //     ], // red
      //     stops: [0.2, 0.7], ),
      //   boxShadow: [
      //     BoxShadow(color: Styles.shadowColor, blurRadius: 4, spreadRadius: -2)
      //   ],
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          // horizontal: CommonSizes.TINY_LAYOUT_W_GAP.w,
          vertical: CommonSizes.TINY_LAYOUT_W_GAP.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: tail,
        ),
      ),
    );
  }
}
