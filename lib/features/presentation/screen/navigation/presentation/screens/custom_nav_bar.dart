import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../../../core/configurations/styles.dart';


class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final bool isButton;
  final double navBarHeight;
  final List<ValueKey> keys;

  CustomNavBarWidget(
      {Key? key,
      required this.keys,
      required this.selectedIndex,
      required this.items,
      required this.onItemSelected,
      this.isButton: false,
      required this.navBarHeight});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, BuildContext context) {
    return Container(
      // width: item.navBarHeight,
      height: item.navBarHeight * 0.9,
      decoration: isSelected
          ? BoxDecoration(
              // borderRadius : BorderRadius.only(
              //   topLeft: Radius.circular(0.r),
              //   topRight: Radius.circular(0.r),
              //   bottomLeft: Radius.circular(0.r),
              //   bottomRight: Radius.circular(0.r),
              // ),
              color: isSelected ? Styles.colorPrimary : Colors.transparent,

              // color:  Color(0xffE8F5ED),
              boxShadow: [
                BoxShadow(
                  color: Styles.dropShadowColorNav.withOpacity(0.247),
                  offset: Offset(0, 6.4),
                  spreadRadius: 0,
                  blurRadius: 16.8,
                ),
                BoxShadow(
                  color: Styles.innerShadowColorNavBarIcon,
                  offset: Offset(0, -1.99),
                  blurRadius: 1.99,
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Styles.innerShadowColorNavBarIcon2,
                  offset: Offset(-0, 1.99),
                  blurRadius: 1.99,
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 0,
                ),
              ],
              // color :Color(0xffE8F5ED),

              shape: BoxShape.circle,
              // borderRadius: BorderRadius.all(
              //   Radius.circular(50),
              // ),
            )
          : BoxDecoration(color: Colors.transparent),

      alignment: Alignment.center,
      // height: kBottomNavigationBarHeight,
      child:
          // Flexible(
          //   key: key,
          //   flex: 4,
          //   child:

          IconTheme(
        data: IconThemeData(
            size: 26.0,
            color: isSelected ? Styles.ColorWhite : Styles.colorPrimary),
        child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.r),
          topRight: Radius.circular(0.r),
          bottomLeft: Radius.circular(0.r),
          bottomRight: Radius.circular(0.r),
        ),
        color: Color(0xffE8F5ED),
        boxShadow: [
          BoxShadow(
            color: Styles.dropShadowColor.withOpacity(0.247),
            offset: Offset(0, 27.6),
            spreadRadius: 0,
            blurRadius: 55.2,
          ),
          BoxShadow(
            color: Styles.innerShadowColor,
            offset: Offset(0, -8.65),
            blurRadius: 8.65,
            blurStyle: BlurStyle.inner,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Styles.innerShadowColorNavBar2,
            offset: Offset(-0, 8.65),
            blurRadius: 8.65,
            blurStyle: BlurStyle.inner,
            spreadRadius: 0,
          ),
        ],
        // color :Color(0xffE8F5ED),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              key: keys[index],
              onTap: () {
                this.onItemSelected(index);
              },
              child: _buildItem(item, selectedIndex == index, context),
            ),
          );
        }).toList(),
      ),
    );
  }
}
