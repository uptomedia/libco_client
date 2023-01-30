import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/helper_functions.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/core/validators/validators.dart';
import 'package:chegg/features/presentation/screen/account/screens/login_screen.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/shared_preferences_items.dart';
import '../../../../../core/ui/custom_textfield.dart';
import '../../../../../injection_container.dart';
import '../../../../../l10n/locale_provider.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../bloc/auth/auth_cubit.dart';
import '../../../bloc/user/user_cubit.dart';
import '../../navigation/presentation/screens/app_main_screen.dart';



class SignUpScreen extends AppStatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends StatefulWidgetState<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Styles.colorTertiary));
  var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Colors.red));
  final _userNameController = TextEditingController();
  final _passWordController = TextEditingController();
  final _fullNameController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passWordFocusNode = FocusNode();
  FocusNode _fullNameFocusNode = FocusNode();
  AppStateModel? appState;
  IconData passwordIcon = Icons.visibility_off;
  bool isHiddenPassword = true;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
        backgroundColor: Styles.colorBackground,
        body: SingleChildScrollView(
            child: SafeArea(
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, userState) {
              if (userState is UserSuccess) {
                // BlocProvider.of<AuthCubit>(context).loggedIn();
              }

              if (userState is UserFailure) {
                Utils().snackBarError(
                    msg: "erorr", scaffoldState: _globalKey);
              }
            },
            builder: (context, userState) {
              if (userState is UserSuccess) {
                return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                  //

                         if (authState is Authenticated) {



                           Utils.pushReplacementNavigateTo(
                             context,
                             //false,
                             RoutePaths.NavigationScreen,
                           );
                           return Container();
                  } else {
                    return _bodyWidget();
                  }
                });
              }
              if(userState is UserLoading){
                return
                  Container(height: 750.h,
                  child:
                  Center(child: CircularProgressIndicator()),);}
              return _bodyWidget();
            },
          ),
        )));
  }

  _bodyWidget() {
    return FormBuilder(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        // height: screenHeight * 0.9,
        margin: EdgeInsets.symmetric(
            horizontal: CommonSizes.SMALL_LAYOUT_W_GAP,
            vertical: CommonSizes.SMALL_LAYOUT_W_GAP),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonSizes.vCustomSpace(114),
            _buildTitle(),
            CommonSizes.vSmallestSpace,
            _buildupperText(),
            CommonSizes.vCustomSpace(27),
            _buildFullName(),
            CommonSizes.vCustomSpace(27),
            _buildUserName(),
            CommonSizes.vCustomSpace(27),
            _buildPassword(),
            CommonSizes.vCustomSpace(27),
            _buildLoginBtn(),
            CommonSizes.vCustomSpace(27),
            _buildCreateAccount()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _buildLoginMethod() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: AppHelperFunctions.buildprofilePhotoWithSize(
                Assets.PNG_Medicine, 50.r),
          ),
        ],
      ),
    );
  }

  _buildLoginBtn() {
    return Center(
      child: CustomButton(
        text: S.of(context).createAccount,
        style: Styles.fontStyle.copyWith(
            color: Styles.textWhiteColor, fontSize: Styles.fontSize20),
        withGradiant: false,
        raduis: 33.r,
        textAlign: TextAlign.center,
        color: Styles.colorPrimary,
        fillColor: Styles.colorPrimary,
        width: 298.w,
        height: 57.h,
        alignmentDirectional: AlignmentDirectional.center,
        onPressed: () async {
          // Utils.pushReplacementNavigateTo(
          //   context,
          //   //false,
          //   RoutePaths.LogIn,
          // );
          submitSignUp();
          //
        },
      ),
    );
  }

  _buildTitle() {
    return Text(
      S.of(context).welcome,
      style: Styles.textStyle.copyWith(
        color: Styles.colorPrimary,
        fontSize: Styles.fontSize32,
      ),
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?      TextAlign.right:TextAlign.left,    );
  }

  void submitSignUp() {
    if (_userNameController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _passWordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(
          user: UserEntity(
            name: _fullNameController.text,
        email: _userNameController.text,
        password: _passWordController.text,
      ));
    }
  }

  _buildCreateAccount() {
    return
      GestureDetector(

          onTap: (){
            Utils.pushNewScreenWithRouteSettings(
                context,
                withNavBar: false,
                screen: LogInScreen(),
                settings: RouteSettings(
                  name: RoutePaths.LogIn,
                )
            );
          },
          child:
      Container(
        width: 360.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).allreadyHaveAccount,
              style: Styles.textStyle.copyWith(
                  color: Styles.textBlackColor,
                  fontSize: Styles.fontSize16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Text(
              S.of(context).login,
              style: Styles.textStyle.copyWith(
                  color: Styles.colorPrimary,
                  fontSize: Styles.fontSize16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            )
          ],
        )));
  }

  _buildupperText() {
    return Text(
      S.of(context).pleaseFillYourInfoInOrderToCreateNewAccount,
      style: Styles.textStyle.copyWith(
        color: Styles.textBlackColor,
        fontSize: Styles.fontSize16,
        fontWeight: FontWeight.w400,
      ),
      maxLines: 3,
      overflow: TextOverflow.clip,
    );
  }

  _buildUserName() {
    return Container(
        // height: 69.h,
        child: CustomTextField(
      controller: _userNameController,

      focusNode: _userNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {},
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        return S.of(context).isNotEmpty;
      },

      // textAlign: TextAlign.left,
      // style: regularFontStyle,
      // toolbarOptions: ToolbarOptions(
      //     copy: true,
      //     paste: true,
      //     cut: true,
      //     selectAll: true),
      // decoration: InputDecoration(
      //   filled: true,
      //   fillColor: Styles.colorTertiary,
      //   hintStyle: TextStyle(
      //     fontFamily: Styles.FontFamily,
      //     fontSize: Styles.fontSize6,
      //     fontWeight: FontWeight.w400,
      //     fontStyle: FontStyle.normal,
      //    ),
      //   border: border,
      //   errorBorder: errorBorder,
      //   enabledBorder: border,
      //   focusedBorder: border,
      //   // helperStyle: TextStyle(fontSize: Styles.fontSize25),
      //   contentPadding: EdgeInsetsDirectional.only(
      //       start: CommonSizes.TINY_LAYOUT_W_GAP.w),
      //   focusedErrorBorder: border,
      //   hintText: S.of(context).userNameHint,
      // ),
      height: 69.h,
      helperText: S.of(context).email,

      suffixIcon: SvgPicture.asset(
        Assets.SVG_Account_email,
        fit: BoxFit.scaleDown,
      ),
      radius: 33.r,
      hasBorder: true,

      keyboardType: TextInputType.text,
    ));
  }

  _buildFullName() {
    return Container(
        // height: 69.h,
        child: CustomTextField(
      controller: _fullNameController,

      focusNode: _fullNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {},
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        return S.of(context).isNotEmpty;
      },

      // textAlign: TextAlign.left,
      // style: regularFontStyle,
      // toolbarOptions: ToolbarOptions(
      //     copy: true,
      //     paste: true,
      //     cut: true,
      //     selectAll: true),
      // decoration: InputDecoration(
      //   filled: true,
      //   fillColor: Styles.colorTertiary,
      //   hintStyle: TextStyle(
      //     fontFamily: Styles.FontFamily,
      //     fontSize: Styles.fontSize6,
      //     fontWeight: FontWeight.w400,
      //     fontStyle: FontStyle.normal,
      //    ),
      //   border: border,
      //   errorBorder: errorBorder,
      //   enabledBorder: border,
      //   focusedBorder: border,
      //   // helperStyle: TextStyle(fontSize: Styles.fontSize25),
      //   contentPadding: EdgeInsetsDirectional.only(
      //       start: CommonSizes.TINY_LAYOUT_W_GAP.w),
      //   focusedErrorBorder: border,
      //   hintText: S.of(context).userNameHint,
      // ),
      height: 69.h,
      helperText: S.of(context).fullName,

      suffixIcon: SvgPicture.asset(
        Assets.SVG_Account_fullname,
        fit: BoxFit.scaleDown,
      ),
      radius: 33.r,
      hasBorder: true,

      keyboardType: TextInputType.text,
    ));
  }

  _buildPassword() {
    return Container(
        height: 69.h,
        child: Center(
            child: CustomTextField(
          controller: _passWordController,
          focusNode: _passWordFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {},
          validator: (value) {
            if (Validators.isNotEmptyString(value ?? '')) {
              return null;
            }
            return S.of(context).isNotEmpty;
          },
          height: 69.h,
          suffixIcon: SvgPicture.asset(
            Assets.SVG_Account_password,
            fit: BoxFit.scaleDown,
          ),
          radius: 33.r,
          helperText: S.of(context).password,
          hasBorder: true,
          keyboardType: TextInputType.text,
        )));
  }
}
