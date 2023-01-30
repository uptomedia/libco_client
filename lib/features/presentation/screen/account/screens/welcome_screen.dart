import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
 import 'package:chegg/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/configurations/assets.dart';
import '../../../../../core/shared_preferences_items.dart';
import '../../../../../injection_container.dart';
import '../../../../../l10n/locale_provider.dart';


class WelcomeScreen extends AppStatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends StatefulWidgetState<WelcomeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  List<String> selectedType = [];
  String _chosenValue = "Student";
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Styles.colorBackground,
        body: SafeArea(
          child: Container(

              child: FormBuilder(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,

                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: SizedBox(
                          height: 171.h,
                          width: 360.w,
                          child: Container(
                              child: SvgPicture.asset(
                            Assets.SVG_Account_UpperPart,
                            fit: BoxFit.fill,
                          )
                              // Image.asset(
                              //   Assets.PNG_Logo,
                              //   fit: BoxFit.fitWidth,
                              // ),
                              ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        // right:MediaQuery.of(context).size.width*0.001 ,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: SizedBox(
                            height: 171.h,
                            width: 360.w,
                            child: Container(
                                child: SvgPicture.asset(
                              Assets.SVG_Account_UpperPart,
                              fit: BoxFit.fill,
                            )
                                // Image.asset(
                                //   Assets.PNG_Logo,
                                //   fit: BoxFit.fitWidth,
                                // ),
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            CommonSizes.vCustomSpace(252),
                            _buildTitle(),
                            _buildupperText(),
                            CommonSizes.vCustomSpace(42),
                            _buildLoginBtn(),
                            CommonSizes.vCustomSpace(24),
                            _buildRegisterBtn()
                          ],
                        ),
                      )
                    ],
                  ),
                )  ),
            ),

        ),

    );
  }

  @override
  void initState() {
    super.initState();
  }

  _buildLoginBtn() {
    return Center(
      child: CustomButton(
        text: S.of(context).login,
        style: Styles.fontStyle.copyWith(
            color: Styles.textWhiteColor,
            fontSize: Styles.fontSize20,
            fontWeight: FontWeight.w900),
        withGradiant: false,
        raduis: 33.r,
        textAlign: TextAlign.center,
        color: Styles.colorPrimary,
        fillColor: Styles.colorPrimary,
        width: 298.w,
        height: 57.h,
        alignmentDirectional: AlignmentDirectional.center,
        onPressed: () async {
          Utils.pushReplacementNavigateTo(
            context,
            //false,
            RoutePaths.LogIn,
          );

          //
        },
      ),
    );
  }

  _buildRegisterBtn() {
    return Center(
      child: CustomButton(
        text: S.of(context).createNewAccount,
        style: Styles.fontStyle.copyWith(
            color: Styles.textWhiteColor,
            fontWeight: FontWeight.w900,
            fontSize: Styles.fontSize20),
        withGradiant: false,
        raduis: 33.r,
        textAlign: TextAlign.center,
        color: Styles.colorPrimary,
        fillColor: Styles.colorPrimary,
        width: 298.w,
        height: 57.h,
        alignmentDirectional: AlignmentDirectional.center,
        onPressed: () async {
          Utils.pushReplacementNavigateTo(
            context,
            //false,
            RoutePaths.SignUp,
          );
        },
      ),
    );
  }

  _buildTitle() {
    return Text(
      S.of(context).welcomeTo,
      style: Styles.textStyle.copyWith(
        color: Styles.textBlackColor,
        fontSize: Styles.fontSize24,
        fontWeight: FontWeight.w900,
      ),
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?      TextAlign.right:TextAlign.left,    );
  }

  _buildupperText() {
    return Text(
      S.of(context).lIBCOEXCHANGE,
      style: Styles.textStyle.copyWith(
        color: Styles.textBlackColor,
        fontSize: Styles.fontSize32,
        fontWeight: FontWeight.w900,
      ),
      maxLines: 3,
      overflow: TextOverflow.clip,
    );
  }
}
