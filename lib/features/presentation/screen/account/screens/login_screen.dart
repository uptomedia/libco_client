import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/custom_textfield.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/core/validators/validators.dart';
import 'package:chegg/features/presentation/screen/account/screens/signup_screen.dart';
  import 'package:chegg/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/configurations/assets.dart';
import '../../../../../core/shared_preferences_items.dart';
import '../../../../../injection_container.dart';
import '../../../../../l10n/locale_provider.dart';
import '../../../../domain/entities/user_entity.dart';
 import '../../../bloc/auth/auth_cubit.dart';
import '../../../bloc/user/user_cubit.dart';
import '../../navigation/presentation/screens/app_main_screen.dart';



class LogInScreen extends AppStatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends StatefulWidgetState<LogInScreen> {

   final _userNameKey = ValueKey<String>("userNameKey");
  final loginKey = ValueKey<String>("loginKey");

  final _passWordKey = ValueKey<String>(
      "passWordKey"); //new GlobalKey<FormFieldState<String>>(debugLabel:"passWordKey");

  final _userNameController = TextEditingController();
  final _passWordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passWordFocusNode = FocusNode();
  late SharedPreferences _spf;

  IconData passwordIcon = Icons.visibility_off;
  bool isHiddenPassword = true;
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Styles.colorTertiary));
  var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Colors.red));

  List<String> UserTypeList = [
    "Student",
    "Teacher",
    "Admin",
  ];
  List<String> selectedType = [];
  String _chosenValue = "Student";
  int _selectedIndex = 0;

  _initfAsync() async {
    _spf = await SharedPreferences.getInstance();

    setState(() {
      _selectedIndex = _spf.getInt(SharedPreferencesKeys.LanguageIndex) ?? 0;
      // _chosenValue=  getStringValue(_selectedIndex+1);
    });
  }
  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: _scaffoldGlobalKey,
resizeToAvoidBottomInset: false,
            backgroundColor: Styles.colorBackground,
            body: SafeArea(
                child:
               BlocConsumer<UserCubit,UserState>(
                builder: (context,userState){

            if (userState is UserSuccess){
              Utils.pushReplacementNavigateTo(
                context,
                //false,
                RoutePaths.NavigationScreen,
              );
              return Container();
              }

if(userState is UserLoading){
  return  Container(height: 750.h,
    child:
    Center(child: CircularProgressIndicator()),);}

            return _bodyWidget();
            },
              listener: (context,userState){
                if (userState is UserSuccess){
                  BlocProvider.of<AuthCubit>(context).loggedIn();
                }
                if (userState is UserFailure){
                  Utils().snackBarError(msg: "invalid email",scaffoldState:
                  _scaffoldGlobalKey);
                }
              },
            )




         )
        )
    );
  }
  _bodyWidget(){
    return    Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        // key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonSizes.vCustomSpace(134),
            _buildTitle(),
            _buildupperText(),
            CommonSizes.vCustomSpace(60),
            _buildUserName(),
            CommonSizes.vCustomSpace(27),
            _buildPassword(),
            CommonSizes.vCustomSpace(27),
            _buildLoginBtn(),
            CommonSizes.vCustomSpace(31),
            _buildForgetPassword(),
            Expanded(child: Container()),
            _buildCreateAccount(),
            CommonSizes.vCustomSpace(31),
          ],
        ),
      ),
    );
}
  @override
  void initState() {
    super.initState();
    _initfAsync();
  }

  _buildLoginBtn() {
    return Center(
      child: CustomButton(
        text: S.of(context).login,
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
          submitSignIn();
          //
        },
      ),
    );
  }
  void submitSignIn() {
    if (_userNameController.text.isNotEmpty &&
        _passWordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(user: UserEntity(
        email: _userNameController.text,
        password: _passWordController.text,
      ));
    }
  }

  _buildTitle() {
    return Text(
      S.of(context).welcomeTo,
      style: Styles.textStyle.copyWith(
        color: Styles.colorPrimary,
        fontSize: Styles.fontSize32,
      ),
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?      TextAlign.right:TextAlign.left,    );
  }

  _buildForgetPassword() {
    return Container(
        width: 360.w,
        child: Text(
          S.of(context).forgotYourPassword,
          style: Styles.textStyle.copyWith(
            color: Styles.colorPrimary,
            fontSize: Styles.fontSize16,
          ),
          textAlign: TextAlign.center,
        ));
  }

  _buildCreateAccount() {
    return
      GestureDetector(onTap: (){
        Utils.pushNewScreenWithRouteSettings(
          context,
        withNavBar: false,
        screen: SignUpScreen(),
        settings: RouteSettings(
        name: RoutePaths.SignUp,
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
              S.of(context).dontHaveAccount,
              style: Styles.textStyle.copyWith(
                  color: Styles.textBlackColor,
                  fontSize: Styles.fontSize16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Text(
              S.of(context).createone,
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
      S.of(context).loginToYourAccount,
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
      key: _userNameKey,
      focusNode: _userNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {},
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        return S.of(context).isNotEmpty;
      },
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

  _buildPassword() {
    return Container(
        height: 69.h,
        child: Center(
            child: CustomTextField(
          controller: _passWordController,
          key: _passWordKey,
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
