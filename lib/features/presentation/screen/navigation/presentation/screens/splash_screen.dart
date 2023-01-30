import 'dart:async';

import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:chegg/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends AppStatefulWidget {
  final int moduleId;

  SplashScreen({this.moduleId = 0});

  @override
  State<StatefulWidget> createState() => _SplashscreenState();
}

class _SplashscreenState extends StatefulWidgetState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("init Splash");
    print("++++++++++++++++++");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            child: Scaffold(
              // backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true, //new line

          body: MultiBlocListener(
            listeners: [
              // BlocListener<AccountBloc, AccountState>(
              //     bloc: sl<AccountBloc>(),
              //     listener: (context, AccountState state) async {
              //       if (state is AccountLoading)
              //         LoadingOverlay.of(context).show();
              //       else {
              //         LoadingOverlay.of(context).hide();
              //         if (state is AccountError) {
              //           if (state.message.toString() == "Session Timed Out" ||
              //               state.message.toString() == "Unauthorised")
              //             await goToLogin();
              //           else
              //             Utils.showToast(state.message.toString());
              //         } else if (state is LogInLoaded) {
              //           sl<AppStateModel>()?.logIn(
              //             token: state.logInEntity?.result.accessToken,
              //             refreshToken: state.logInEntity?.result.refreshToken,
              //             expires: state.logInEntity?.result.expiresIn,
              //           );
              //           print(state.logInEntity?.result.accessToken);
              //
              //           sl<AccountBloc>().add(GetUserProfileEvent(
              //               profileParams: ProfileParams(
              //                   body: ProfileParamsBody(
              //                       token: state
              //                           .logInEntity?.result.accessToken))));
              //         }
              //       }
              //     }),
              // BlocListener<HomeCalenderBloc, HomeCalenderState>(
              //     bloc: bloc,
              //     listener: (context, HomeCalenderState state) async {
              //       if (state is HomeError) {
              //         if (state.message.toString() == "Session Timed Out" ||
              //             state.message.toString() == "Unauthorised")
              //           await goToLogin();
              //         else {
              //           Utils.showToast(state.message.toString());
              //
              //
              //
              //         }
              //       } else if (state is GetOccupancyByDoctorsLoaded) {
              //         ApiCalledNum++;
              //
              //         Provider.of<HomeCountNotifier>(context, listen: false)
              //                 .appointmentCount =
              //             state.getOccupancyByDoctorsEntity!.result
              //                 .items[DateTime.now().day - 1].appointmentCount;
              //         if (ApiCalledNum == 2) {
              //           Utils.popNavigateToFirst(context);
              //
              //
              //           setState(() {});
              //         }
              //       }
              //     }),
            ],
            child: SafeArea(
              child: Consumer<AppStateModel>(
                builder:
                    (BuildContext context, AppStateModel value, Widget? child) {
                  // appState = value;
                  return FormBuilder(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Scaffold(
                      backgroundColor: Styles.splashBackgroundColor,
                      body: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              color: Styles.splashBackgroundColor),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                bottom: 0,
                                child: SizedBox(
                                  // height:MediaQuery.of(context).size.height*0.4 ,
                                  child: Center(
                                    child: Image.asset(
                                      Assets.PNG_spalsh_Logo,
                                      scale: 1.2,
                                    ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: customheight! * 0.30,
                                      // right:MediaQuery.of(context).size.width*0.001 ,
                                      child: SizedBox(
                                        child: Center(
                                            child: SvgPicture.asset(
                                          Assets.PNG_spalsh_Logo)
                                      // Image.asset(
                                            //   Assets.PNG_Logo,
                                            //   fit: BoxFit.fitWidth,
                                            // ),
                                            ),
                                      ),
                                    ),
                                    Positioned(
                                      top: customheight! * 0.4,
                                      // right:MediaQuery.of(context).size.width*0.001 ,
                                      child: SizedBox(
                                        child: Center(
                                      child: SvgPicture.asset(
                                          Assets.PNG_spalsh_Logo)
                                      // Image.asset(
                                      //   Assets.PNG_Logo,
                                      //   fit: BoxFit.fitWidth,
                                      // ),
                                      ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),
          ),
        )));
  }



  Future<String?> ShowErrorDialog(String title, String message) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.r),
            child: CustomButton(
              text: S.of(context).ok,
              style: TextStyle(
                  fontSize: Styles.fontSize4, fontWeight: FontWeight.w500),
              withGradiant: false,
              raduis: 15,
              textAlign: TextAlign.center,
              color: Styles.colorPrimary,
              fillColor: Styles.colorPrimary,
              width: customWidth! * 0.25,
              height: customheight! * 0.04,
              alignmentDirectional: AlignmentDirectional.center,
              onPressed: () => Navigator.pop(context, 'OK'),
            ),
          ),
        ],
      ),
    );
  }

  goToLogin() async {
    sl<AppStateModel>().logOut();
    await ShowErrorDialog(S.of(context).loginError,
        S.of(context).weExperiencedAnErrorLoggingYouInWouldYouPlease);
    // await _spf.remove(SharedPreferencesKeys.TOKEN);
    // await _spf.remove(SharedPreferencesKeys.IS_LOGGED_IN);
    // await _spf.remove(SharedPreferencesKeys.USER_INFO);
    // Constants.loggedFormRegister = false;
    // Phoenix.rebirth(context);
    setState(() {
      Utils.popNavigateToFirst(context);
      Utils.pushReplacementNavigateTo(
        context,
        RoutePaths.LogIn,
      );
    });
  }

  void CallApi(int module) {
    switch (module) {
      case 0:
        Future.delayed(const Duration(milliseconds: 10), () {
          // bloc.add(GetOccupancyByDoctorsEvent(
          //     getOccupancyByDoctorsParams: GetOccupancyByDoctorsParams(
          //         body: GetOccupancyByDoctorsParamsBody(
          //   startDateTime:
          //       DateTime(DateTime.now().year, DateTime.now().month, 1, 0, 0, 0),
          //   endDateTime: DateTime(
          //       DateTime.now().year, DateTime.now().month + 1, 1, 0, 0, 0),
          //   doctorIds: null,
          // ))));
        });
        break;
      case 1:
        break;
    }
  }
}
