import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/features/presentation/screen/account/screens/profile_screen.dart';
import 'package:chegg/features/presentation/screen/account/screens/setting_screen.dart';
 import 'package:chegg/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

  import '../../../../../domain/entities/user_entity.dart';
import '../../../home/presentation/screens/exchange_table_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import 'custom_nav_bar.dart';

class AppMainScreen extends AppStatefulWidget {
  late final BuildContext menuScreenContext;
UserEntity? userEntity;
  AppMainScreen(
          { this.userEntity
      }   );

  @override
  State<StatefulWidget> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends StatefulWidgetState<AppMainScreen>
    with SingleTickerProviderStateMixin<AppMainScreen> {

  late PersistentTabController _controller;
   DateTime? backButtonPressTime;
  static const flutterToastDuration = const Duration(seconds: 3);

  List<ValueKey<String>> home = [
    ValueKey<String>("calenderPage"),
    ValueKey<String>("appointmentPage"),
    ValueKey<String>("addAppointmentPage"),
    ValueKey<String>("patientPage"),
    ValueKey<String>("profilePage")
  ]; //new GlobalKey<FormFieldState<String>>(debugLabel:"passWordKey");
  late Widget _form;
  int navIndex = 0, prevNavIndex = 0;

  bool pass = false;
  int _currentIndex = 0;
  late Widget currentScreen;

  List<Widget> _buildScreens() {
    return [
      HomeScreen(userEntity: widget.userEntity,),
      ExchangeTableScreen(),
      ProfileScreen(),
      SettingScreen(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_Navigation_homeActive,
          fit: BoxFit.scaleDown,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_Navigation_home,
          fit: BoxFit.scaleDown,
        ),
        title: S.of(context).home,
        activeColorPrimary: Styles.colorPrimary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_Navigation_homeActive,
          fit: BoxFit.scaleDown,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_Navigation_home,
          fit: BoxFit.scaleDown,
        ),
        title: S.of(context).home,
        activeColorPrimary: Styles.colorPrimary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: SvgPicture.asset(
      //     Assets.SVG_Navigation_whatsappActive,
      //     fit: BoxFit.scaleDown,
      //   ),
      //   inactiveIcon: SvgPicture.asset(
      //     Assets.SVG_Navigation_whatsapp,
      //     fit: BoxFit.scaleDown,
      //   ),
      //   title: S.of(context).home,
      //   activeColorPrimary: Styles.colorPrimary,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_Navigation_profileActive,
          fit: BoxFit.scaleDown,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_Navigation_profile,
          fit: BoxFit.scaleDown,
        ),
        title: S.of(context).home,
        activeColorPrimary: Styles.colorPrimary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_Navigation_settingActive,
          fit: BoxFit.scaleDown,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_Navigation_setting,
          fit: BoxFit.scaleDown,
        ),
        title: S.of(context).home,
        activeColorPrimary: Styles.colorPrimary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body:
             PersistentTabView.custom(
          context,
          controller: _controller,
          screens: _buildScreens(),
          // items: _navBarsItems(),
          confineInSafeArea: true,

          backgroundColor: Colors.white,
          // Default is Colors.white.
          handleAndroidBackButtonPress: true,
          onWillPop: (context) async {
            // FocusScope.of(context!).unfocus();

            DateTime currentTime = DateTime.now();
            bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
                backButtonPressTime == null ||
                    currentTime.difference(backButtonPressTime!) >
                        flutterToastDuration;
            if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
              backButtonPressTime = currentTime;

              Fluttertoast.showToast(
                  msg: S.of(context!).pressTwiceToExit,
                  textColor: Styles.ColorWhite,
                  backgroundColor: Styles.colorPrimary.withOpacity(1));
              return false;
            } else {
              SystemNavigator.pop();

              return true;
            }
          },
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: false,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,

          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

          // decoration: NavBarDecoration(
          //   borderRadius: BorderRadius.circular(10.0),
          //   colorBehindNavBar: Colors.white,
          // ),
          // popAllScreensOnTapOfSelectedTab: true,
          // popActionScreens: PopActionScreensType.all,
          // itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          // duration: Duration(milliseconds: 200),
          // curve: Curves.ease,
          // ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),

          customWidget: CustomNavBarWidget(
            items: _navBarsItems(),
            navBarHeight: CommonSizes.navBarHeight,
            keys: home,
            onItemSelected: (index) {
              _controller.index = index;
              setState(() {});
            },
            selectedIndex: _controller.index,
          ),
          itemCount: 4,
          navBarHeight: 88.h,
        ));
  }





  @override
  void initState() {
    super.initState();

    widget.menuScreenContext = context;
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() {
      if (mounted)
        setState(() {
          navIndex = _controller.index;
        });
    });

   }


  @override
  void dispose() {
    super.dispose();
  }


}
