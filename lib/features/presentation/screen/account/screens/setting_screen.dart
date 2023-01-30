import 'dart:io';

import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:chegg/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/shared_preferences_items.dart';
import '../../../../../core/ui/widget/LILA/language_drop_down.dart';
import '../../../../../l10n/locale_provider.dart';
import '../../../../../l10n/selected_provider.dart';
import '../../../bloc/user/user_cubit.dart';

class SettingScreen extends AppStatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends StatefulWidgetState<SettingScreen>
    with AutomaticKeepAliveClientMixin<SettingScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
   var imgVariable;
  late double paddingHorizantal;
  bool loaded = false;
  IconData passwordIcon = Icons.visibility_off;
  bool isHiddenPassword = true;
  late XFile _image;
  late bool pick;
  final picker = ImagePicker();
  bool isopen = false;
  List<String> selectedLanguges = [];
   String _selectedImage = "english";
   bool passed = false;
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passWordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _passWordFocusNode = FocusNode();
  List<String> Languages = [
    "english",
    "العربية",
    "German",
  ];
  String rootKey = "Profile";

  late ValueKey updateProfileImage,
      editProfilebtn,
      changeLanguageBtn,
      logoutbtn,
      cameraBtn,
      galleryBtn,
      changeLanguageEn,
      changeLanguageAr,
      changeLanguageDe;

  setvalueKey() {
    updateProfileImage = ValueKey<String>(rootKey + "updateProfileImage");
    editProfilebtn = ValueKey<String>(rootKey + "editProfilebtn");
    changeLanguageBtn = ValueKey<String>(rootKey + "changeLanguageBtn");
    logoutbtn = ValueKey<String>(rootKey + "logoutbtn");
    galleryBtn = ValueKey<String>(rootKey + "galleryBtn");
    cameraBtn = ValueKey<String>(rootKey + "cameraBtn");
  }
  late SharedPreferences _spf;

  _initfAsync() async {
    _spf = await SharedPreferences.getInstance();

    setState(() {
      _selectedIndex = _spf.getInt(SharedPreferencesKeys.LanguageIndex) ?? 0;
      _chosenValue = getStringValue(_selectedIndex + 1);
      _selectedScale=0;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!passed) {
      passed = true;
    }
    if(BlocProvider.of<UserCubit>(context).state is UserInitial
        || BlocProvider.of<UserCubit>(context).state is UserLoading
        ||BlocProvider.of<UserCubit>(context).state is UserFailure
    // ||BlocProvider.of<UserCubit>(context).state is UserSuccess
    )
      BlocProvider.of<UserCubit>(context).getUserProfile(uid:
      Constants.UID);
    else{



    }
    _initfAsync();
    pick = false;
    setvalueKey();
  }
  String _chosenValue = "العربية";
  int _selectedIndex = 0;
  int _selectedScale = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
            child:
            BlocConsumer<AuthCubit,AuthState>(
                bloc: BlocProvider.of<AuthCubit>(context),
                listener: (context, AuthState state) {
                  print(state);
                  if(state is UnAuthenticated){
                     Phoenix.rebirth(context);
                  }



                },
                builder: (context, userState) {

                  if(userState is AuthLoading){
                    return CircularProgressIndicator();
                  }
                  return   Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonSizes.vCustomSpace(16.2),
                    Container(
                        height: 42.r,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Container(
                                  height: 42.r,
                                  width: 42.r,
                                  decoration: Styles.decotrationBoxStyled(
                                      radius: 42.r,
                                      innerOffset1: Offset(0, -1.42),
                                      innerblurRadius1: 1.42,
                                      innerShadawColor1: Color(0xffDCE9E1),
                                      innerOffset2: Offset(0, 1.42),
                                      innerblurRadius2: 1.42,
                                      innerShadawColor2: Color(0xffF1FFF7),
                                      dropblurRadius: 11.2,
                                      dropOffset: Offset(0, 5.6),
                                      dropShadawColor:
                                      Color(0xff2E312F).withOpacity(0.14)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    // child:
                                    // SvgPicture.asset(
                                    //               Assets.SVG_Cart,
                                    //               // color: Styles.colorPrimary,
                                    //             )
                                  )),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildTitle(
                                        S.of(context).welcom ,
                                        Styles.textStyle.copyWith(
                                            color: Styles.textBlackColor,
                                            fontSize: Styles.fontSize11,
                                            fontWeight: FontWeight.w400)),
    BlocConsumer<UserCubit,UserState>(
    bloc: BlocProvider.of<UserCubit>(context),
    listener: (context, UserState state) {
                  print(state);
                  if(state is UserInitial){}
                  }

                  ,
        builder:  (context,state){
          if (userState is ProfileLoaded  ){
      return
                                    _buildTitle(
                                        Provider.of<SelectedProvider>(context, listen: false).userEntity.name??"",
                                        Styles.textStyle.copyWith(
                                            color: Styles.textBlackColor,
                                            fontSize: Styles.fontSize15,
                                            fontWeight: FontWeight.w600));}
          return SizedBox(height: 8.h,width: 10.w,child:CircularProgressIndicator());
                  }),
                                  ],
                                )),
                            SizedBox(
                              child: Container(
                                  height: 42.r,
                                  width: 42.r,
                                  child: Center(
                                    child: Icon(Icons.search),
                                  )),
                            ),
                          ],
                        )),
                    CommonSizes.vCustomSpace(51),
                    _buildLanguages(),
                    CommonSizes.vCustomSpace(38),
                    _buildShare(),
                    CommonSizes.vCustomSpace(38),
                    _buildLogout(),
                  ],
                );})

          ),
      ),
    );
  }

  _buildLanguages() {
    return Container(
      height: 69.h,
      width: 298.w,
      padding: EdgeInsets.symmetric(horizontal: 31.w),
      decoration: Styles.decotrationBoxStyled(
          radius: 33.r,
          innerOffset1: Offset(0, 5.76),
          innerblurRadius1: 5.76,
          innerShadawColor1: Color(0xffFF0FDF5),
          innerOffset2: Offset(0, -5.76),
          innerblurRadius2: 5.76,
          innerShadawColor2: Color(0xffDEEAE3),
          dropblurRadius: 48.39,
          dropOffset: Offset(0, 24.47),
          dropShadawColor: Color(0xff2E312F1F).withOpacity(0.163)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
              child:
              LanguageDropDown(
                menuBackground: Colors.white,
                initValue: _chosenValue,

                borderColor: Colors.transparent,
//  AppHelperFunctions.getStylesStatusButton(_selectedIndex),
                items: Languages,
                // widget.providerEntity.countryrate??[],
                title: "choose",
                valueChanged: (value) {

                  setState(() async {
                    _selectedIndex =value;
                        // Languages.indexOf(value ?? "") ?? 0;
                    _chosenValue = getStringValue(_selectedIndex + 1);

                    await _spf.setString(
                        SharedPreferencesKeys.LanguageCode,
                        getLocal(_selectedIndex).languageCode);
                    await _spf.setInt(
                        SharedPreferencesKeys.LanguageIndex,
                        _selectedIndex);

                    Provider.of<LocaleProvider>(context, listen: false)
                        .setLocale(getLocal(_selectedIndex));
                  });

                 },
                cornerRadius: 50,
                titleColor: Styles.FontColorBlack,
              )),

          // Expanded(
          //     child: _buildTitle(
          //         "langauge",
          //         Styles.fontStyle.copyWith(
          //             fontWeight: FontWeight.w400,
          //             fontSize: Styles.fontSize16,
          //             color: Styles.textBlackColor))),
          SizedBox(
            child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      Assets.SVG_setting_languges,
                      height: 24.r,
                      width: 24.r,
                      fit: BoxFit.scaleDown,
                    ))),
          )
        ],
      ),
    );
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Libco Company',
        text: 'Great',
        linkUrl: 'https://flutter.dev/',
       );
  }
  _buildShare() {
    return

      GestureDetector(
          onTap: (){
share();
          },
          child:
    Container(
      height: 69.h,
      width: 298.w,
      padding: EdgeInsets.symmetric(horizontal: 31.w),
      decoration: Styles.decotrationBoxStyled(
          radius: 33.r,
          innerOffset1: Offset(0, 5.76),
          innerblurRadius1: 5.76,
          innerShadawColor1: Color(0xffFF0FDF5),
          innerOffset2: Offset(0, -5.76),
          innerblurRadius2: 5.76,
          innerShadawColor2: Color(0xffDEEAE3),
          dropblurRadius: 48.39,
          dropOffset: Offset(0, 24.47),
          dropShadawColor: Color(0xff2E312F1F).withOpacity(0.163)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: _buildTitle(
                 S.of(context).share ,
                  Styles.fontStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Styles.fontSize16,
                      color: Styles.textBlackColor))),
          SizedBox(
            child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      Assets.SVG_setting_share,
                      height: 24.r,
                      width: 24.r,
                      fit: BoxFit.scaleDown,
                    ))),
          )
        ],
      ),
    ));
  }

  _buildLogout() {
    return
      GestureDetector(
        onTap: (){
          BlocProvider.of<AuthCubit>(context).loggedOut();
        },
        child:
      Container(
      height: 69.h,
      width: 298.w,
      padding: EdgeInsets.symmetric(horizontal: 31.w),
      decoration: Styles.decotrationBoxStyled(
          radius: 33.r,
          innerOffset1: Offset(0, 5.76),
          innerblurRadius1: 5.76,
          innerShadawColor1: Color(0xffFF0FDF5),
          innerOffset2: Offset(0, -5.76),
          innerblurRadius2: 5.76,
          innerShadawColor2: Color(0xffDEEAE3),
          dropblurRadius: 48.39,
          dropOffset: Offset(0, 24.47),
          dropShadawColor: Color(0xff2E312F1F).withOpacity(0.163)),
      child:


      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: _buildTitle(
                 S.of(context).logout ,
                  Styles.fontStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Styles.fontSize16,
                      color: Styles.textBlackColor))),
          SizedBox(
            child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      Assets.SVG_setting_logout,
                      height: 24.r,
                      width: 24.r,
                      fit: BoxFit.scaleDown,
                    ))),
          )
        ],
      )),
    );
  }

  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
      TextAlign.right:TextAlign.left ,
    );
  }

  getStringValue(int index) {
    switch (index) {
      case 1:
        return S.of(context).english;
      case 2:
        return "العربية";
      case 3:
        return S.of(context).german;

      default:
        {
          return S.of(context).german;
        }
    }
  }

  Locale getLocal(int index) {
    switch (index) {
      case 0:
        return Locale('en');

      case 1:
        return Locale('ar');

      case 2:
        return Locale('de');

      default:
        return Locale('en');
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() async {
      if (pickedFile != null) {
        _image = pickedFile;
        pick = true;
        File file = File(
          _image.path,
        );

        file = (await ImageCropper().cropImage(
          sourcePath: _image.path,
          cropStyle: CropStyle.circle,
          maxWidth: 512,
          maxHeight: 512,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                ]
              : [
                  CropAspectRatioPreset.square,
                ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: "cropper",
                toolbarColor: Styles.ColorBlueTurquoiseLite,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false),
            IOSUiSettings(
              title: "S.of(context).cropper",
            )
          ],
        )) as File;
        await file.length().then((newvalue) async {
          if (newvalue <= 1024000)
//wait for backend update APi
          {
//wait for backend update APi
            loaded = false;

            //}
          } else {
            Utils.showToast("S.of(context).sizemorethanMBB");
          }
        });
      } else {
        print("S.of(context).noImageSelected");
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() async {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
        pick = true;
        //                   if(pick){
        File file = File(_image.path);
        await file.length().then((value) async {
          file = (await ImageCropper().cropImage(
              sourcePath: _image.path,
              cropStyle: CropStyle.circle,
              maxWidth: 512,
              maxHeight: 512,
              aspectRatioPresets: Platform.isAndroid
                  ? [
                      CropAspectRatioPreset.square,
                    ]
                  : [
                      CropAspectRatioPreset.square,
                    ],
              uiSettings: [
                AndroidUiSettings(
                    toolbarTitle: "S.of(context).cropper",
                    toolbarColor: Styles.ColorBlueTurquoiseLite,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.square,
                    lockAspectRatio: false),
                IOSUiSettings(
                  title: " S.of(context).cropper",
                )
              ])) as File;
          await file.length().then((newvalue) async {
            if (newvalue <= 1024000)
//wait for backend update APi
            {
//wait for backend update APi
              loaded = false;
            } else {
              Utils.showToast("Image size is bigger than 1MB");
            }
          });
        });
//                   else{
//                     // Utils.showToast("Image not changed");
//                     Utils.popNavigate(context);
//
//                   }
      } else {
        print('No image selected.');
      }
    });
  }

  void selectimage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    key: galleryBtn,
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                      "S.of(context).photolibrary",
                      style: TextStyle(
                        fontFamily: Styles.FontFamily,
                      ),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  key: cameraBtn,
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    "S.of(context).camera",
                    style: TextStyle(
                      fontFamily: Styles.FontFamily,
                    ),
                  ),
                  onTap: () {
                    getImage();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
