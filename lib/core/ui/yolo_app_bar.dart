import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YoloAppBar extends AppStatelessWidget {
  final String title;
  final List<Widget>? tail;
  final Function? onPressed;
  final bool withBack;

  YoloAppBar({
    this.title = "",
    this.onPressed,
    this.tail,
    this.withBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CommonSizes.appBarHeight,
      decoration: BoxDecoration(
        color: Styles.colorPrimary,
        boxShadow: [
          BoxShadow(color: Styles.shadowColor, blurRadius: 4, spreadRadius: -2)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CommonSizes.BIG_LAYOUT_W_GAP.w,
          vertical: CommonSizes.TINY_LAYOUT_W_GAP.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => this.withBack
                  ? (this.onPressed ?? Navigator.of(context).pop())
                  : {},
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: this.withBack
                        ? Styles.colorBackground
                        : Colors.transparent,
                    size: 55.r,
                  ),
                  CommonSizes.hSmallerSpace,
                  Text(
                    this.title ?? "    ",
                    style: TextStyle(
                      fontFamily: Styles.FontFamily,
                      color: Styles.colorPrimary,
                      fontSize: Styles.fontSize3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            if ((tail != null && (tail?.length ?? 0) > 0))
              Row(
                children: [
                  if (tail != null && (tail?.length ?? 0) > 0) ...tail!,
                  // if (withSearch)
                  //   InkWell(
                  //     onTap: () {
                  //       pushNewScreenWithRouteSettings(
                  //         context,
                  //         screen: SearchScreen(),
                  //         settings: RouteSettings(
                  //           name: SearchScreen.routeName,
                  //         ),
                  //       );
                  //     },
                  //     child: Hero(
                  //       tag: SEARCH_HERO,
                  //       child: Icon(
                  //         Icons.search,
                  //         color: CoreStyle.mozzaikBlackTextColor,
                  //         size: ScreenUtil().setHeight(65),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
