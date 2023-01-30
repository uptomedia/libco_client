import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chegg/core/app/state/appstate.dart';
import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/domain/entities/user_entity.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:chegg/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/shared_preferences_items.dart';
import '../../../../../core/ui/chegg_container.dart';
import '../../../../../core/ui/custom_textfield.dart';
import '../../../../../core/validators/validators.dart';
import '../../../../../l10n/locale_provider.dart';
import '../../../../../l10n/selected_provider.dart';
import '../../../bloc/user/user_cubit.dart';



class ProfileScreen extends AppStatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StatefulWidgetState<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late SharedPreferences _spf;
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
  String _chosenValue = "English";
  int selectedIndex = 0;
   int _selectedIndex = 0;
  bool passed = false;
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passWordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _passWordFocusNode = FocusNode();
  List<String> Languages = [
    "English",
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
bool shouldSave=false;
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
    else {
      profileLoadedTMP =
          Provider
              .of<SelectedProvider>(context, listen: false)
              .userEntity;
      _userNameController.text = profileLoadedTMP.name ?? "";
      _passWordController.text = profileLoadedTMP.password ?? "";
      _phoneNumberController.text = profileLoadedTMP.status ?? "";
    }

      BlocProvider.of<UserCubit>(context).getUserProfile(uid:
      Constants.UID);
    shouldSave=false;
    pick = false;
    setvalueKey();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  late UserEntity profileLoadedTMP;
  Future<void> refreshData()async {
    BlocProvider.of<UserCubit>(context).getUserProfile(uid:
    Constants.UID);
    shouldSave=false;
    pick = false;
  }
  @override
  Widget build(BuildContext context) {
    return

      GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

        child: Scaffold(
        backgroundColor: Styles.colorBackground,
        body: SafeArea(
          child:RefreshIndicator(
        onRefresh: refreshData,
    child:    BlocConsumer<UserCubit,UserState>(
              bloc: BlocProvider.of<UserCubit>(context),
              listener: (context, UserState state) {
                print(state);
                if(state is UserInitial){
                  profileLoadedTMP= Provider.of<SelectedProvider>(context, listen: false).userEntity;
                }else if (state is UserSuccess)
                {
                  profileLoadedTMP= Provider.of<SelectedProvider>(context, listen: false).userEntity;
                }

                else if(state is ProfileLoaded){
                  profileLoadedTMP=state.userEntity;
                  Provider.of<SelectedProvider>(context, listen: false).setUserEntity(state.userEntity);
                  shouldSave=false;

                }


              },
              builder: (context, userState) {
                if (userState is ProfileLoaded  ||
                    userState is UpdateProfileLoaded) {

                  return

                    SingleChildScrollView(
              child:

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildSaveBtn(),
                            CommonSizes.vCustomSpace(30),
                            _buildProfileImage(),
                            CommonSizes.vCustomSpace(42),
                            _buildfullName(),
                            CommonSizes.vCustomSpace(32),
                            _buildphoneNumber(),
                            CommonSizes.vCustomSpace(32),
                            _buildpassword(),
                          ],
                        )  )
                        ;}
                    return SizedBox(
                      height: 500.h,
                      child:
                    Center(child: CircularProgressIndicator()),);
                  }

              )

    ),
        ),

        )   );
  }
  _buildSaveBtn(){
    return
GestureDetector(
  onTap: (){
    if(shouldSave){
      BlocProvider.of<UserCubit>(context).updateUserProfile(userEntity:

      profileLoadedTMP);
      shouldSave=false;
    }
  },
  child:


        Align(
            alignment:
            sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
            Alignment.topLeft:Alignment.topRight,
            child:          shouldSave ?
            Container(
            height: 38.r,
            width: 38.r,
            margin: EdgeInsets.all(20.r),
            decoration: Styles.decotrationBoxStyled(radius: 12.r),

            child:
          SvgPicture.asset(
                    Assets.SVG_Account_save,
                    fit: BoxFit.scaleDown,
                   ),
      ):Container(height: 38.r,
              width: 38.r,margin: EdgeInsets.all(20.r),))
    );
  }

  _buildfullName() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(
               S.of(context).fullName ,
                Styles.textStyle.copyWith(
                    color: Styles.textBlackDarkColor,
                    fontSize: Styles.fontSize16,
                    fontWeight: FontWeight.w400)),
            CommonSizes.vCustomSpace(16.h),

            Container(
                height: 69.h,
                child:
                Stack(children: [
                  CustomTextField(
                    isEditable: shouldSave,
                    controller: _userNameController,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(33.r),
                        topRight: Radius.circular(33.r),
                        bottomLeft: Radius.circular(33.r),
                        bottomRight: Radius.circular(33.r),
                      ),
                      color: Color(0xffE8F5ED),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff2E312F1F).withOpacity(0.121),
                          offset: Offset(0, 24.47),
                          spreadRadius: 0,
                          blurRadius: 48.93,
                        ),
                        BoxShadow(
                          color: Color(0xffF0FDF5),
                          offset: Offset(0, 5.76),
                          blurRadius: 5.76,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0xffDEEAE3),
                          offset: Offset(-0, -5.76),
                          blurRadius: 5.76,
                          blurStyle: BlurStyle.inner,
                          spreadRadius: 0,
                        ),
                      ],
                      // color :Color(0xffE8F5ED),
                    ),
                    focusNode: _userNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      profileLoadedTMP.name=value;

                    },
                    onFieldSubmitted: (value) {
                      profileLoadedTMP.name=value;
                    },
                    validator: (value) {
                      if (Validators.isNotEmptyString(value ?? '')) {
                        return null;
                      }
                      return S.of(context).isNotEmpty;
                    },
                    height: 69.h,
                    helperText: S.of(context).fullName,
                    // suffixIcon:
                    // GestureDetector(
                    //     onTap: (){
                    //       if(shouldSave==false){
                    //         shouldSave=true;
                    //         setState((){});
                    //       }
                    //     },
                    //     child:
                    //     SizedBox(
                    //         width: 42.w,
                    //         child: SvgPicture.asset(
                    //           Assets.SVG_Account_edite,
                    //           fit: BoxFit.scaleDown,
                    //         )    )),
                    radius: 33.r,
                    hasBorder: true,
                    keyboardType: TextInputType.text,
                  ),
                  sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)
                      =="ar"?
                  Positioned(
                      left:
                      20.w,

                      bottom: 0,
                      top: 0,
                      child:
                      GestureDetector(
                          onTap: (){
                            shouldSave=true;
                            setState((){});
                          },
                          child:
                          SizedBox(
                            width: 42.w,
                            child: SvgPicture.asset(
                              Assets.SVG_Account_edite,
                              fit: BoxFit.scaleDown,
                            )    ,))):
                  Positioned(
                      right:
                      20.w,

                      bottom: 0,
                      top: 0,
                      child:
                      GestureDetector(
                          onTap: (){
                            if(shouldSave==false){
                              shouldSave=true;
                              setState((){});}
                          },
                          child:
                          SizedBox(
                            width: 42.w,
                            child: SvgPicture.asset(
                              Assets.SVG_Account_edite,
                              fit: BoxFit.scaleDown,
                            )    ,)))
                ],),
                ),


          ],
        ));
  }

  _buildphoneNumber() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(
               S.of(context).phoneNumber ,
                Styles.textStyle.copyWith(
                    color: Styles.textBlackDarkColor,
                    fontSize: Styles.fontSize16,
                    fontWeight: FontWeight.w400)),
            CommonSizes.vCustomSpace(16.h),

            Container(
                height: 69.h,
                child:

                Stack(children: [

                  CustomTextField(
                  controller: _phoneNumberController,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(33.r),
                      topRight: Radius.circular(33.r),
                      bottomLeft: Radius.circular(33.r),
                      bottomRight: Radius.circular(33.r),
                    ),
                    color: Color(0xffE8F5ED),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff2E312F1F).withOpacity(0.121),
                        offset: Offset(0, 24.47),
                        spreadRadius: 0,
                        blurRadius: 48.93,
                      ),
                      BoxShadow(
                        color: Color(0xffF0FDF5),
                        offset: Offset(0, 5.76),
                        blurRadius: 5.76,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0xffDEEAE3),
                        offset: Offset(-0, -5.76),
                        blurRadius: 5.76,
                        blurStyle: BlurStyle.inner,
                        spreadRadius: 0,
                      ),
                    ],
                    // color :Color(0xffE8F5ED),
                  ),
                  focusNode: _phoneNumberFocusNode,
                  textInputAction: TextInputAction.next,
                  onChanged:
                  (value){
                    profileLoadedTMP.status=value;

                  },
                  onFieldSubmitted: (value) {
                    profileLoadedTMP.status=value;

                  },
                  validator: (value) {
                    if (Validators.isNotEmptyString(value ?? '')) {
                      return null;
                    }
                    return S.of(context).isNotEmpty;
                  },
                  height: 69.h,
                  helperText: S.of(context).phoneNumber,
                   radius: 33.r,
                  hasBorder: true,
                  keyboardType: TextInputType.text,
                ),

                  sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)
                      =="ar"?
              Positioned(
                  left:
                  20.w,

                   bottom: 0,
                  top: 0,
                  child:
                  GestureDetector(
                      onTap: (){
                        shouldSave=true;
                        setState((){});
                      },
                      child:
                      SizedBox(
                        width: 42.w,
                        child: SvgPicture.asset(
                          Assets.SVG_Account_edite,
                          fit: BoxFit.scaleDown,
                        )    ,))):
                  Positioned(
                      right:
                      20.w,

                      bottom: 0,
                      top: 0,
                      child:
                      GestureDetector(
                          onTap: (){
                        if(shouldSave==false){
                            shouldSave=true;
                            setState((){});}
                          },
                          child:
                          SizedBox(
                            width: 42.w,
                            child: SvgPicture.asset(
                              Assets.SVG_Account_edite,
                              fit: BoxFit.scaleDown,
                            )    ,)))
            ]))
          ],
        ));
  }

  _buildpassword() {
    return Container(
      // height: 69.h,
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(
                S.of(context).password,
                Styles.textStyle.copyWith(
                    color: Styles.textBlackDarkColor,
                    fontSize: Styles.fontSize16,
                    fontWeight: FontWeight.w400)),
            CommonSizes.vCustomSpace(16.h),
            Container(
                height: 69.h,
                child:

                Stack(children: [

                  CustomTextField(
                  controller: _passWordController,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(33.r),
                      topRight: Radius.circular(33.r),
                      bottomLeft: Radius.circular(33.r),
                      bottomRight: Radius.circular(33.r),
                    ),
                    color: Color(0xffE8F5ED),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff2E312F1F).withOpacity(0.121),
                        offset: Offset(0, 24.47),
                        spreadRadius: 0,
                        blurRadius: 48.93,
                      ),
                      BoxShadow(
                        color: Color(0xffF0FDF5),
                        offset: Offset(0, 5.76),
                        blurRadius: 5.76,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0xffDEEAE3),
                        offset: Offset(-0, -5.76),
                        blurRadius: 5.76,
                        blurStyle: BlurStyle.inner,
                        spreadRadius: 0,
                      ),
                    ],
                    // color :Color(0xffE8F5ED),
                  ),
                  focusNode: _passWordFocusNode,
                  textInputAction: TextInputAction.next,
                  onChanged: (value){
                    profileLoadedTMP.password=value;

                  },
                  onFieldSubmitted: (value) {
                    profileLoadedTMP.password=value;

                  },
                  validator: (value) {
                    if (Validators.isNotEmptyString(value ?? '')) {
                      return null;
                    }
                    return S.of(context).isNotEmpty;
                  },
                  height: 69.h,
                  helperText: S.of(context).password,
                   radius: 33.r,
                  hasBorder: true,
                  keyboardType: TextInputType.text,
                ),
                  sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)
                      =="ar"?
                  Positioned(
                      left:
                      20.w,

                      bottom: 0,
                      top: 0,
                      child:
                      GestureDetector(
                          onTap: (){
                            shouldSave=true;
                            setState((){});
                          },
                          child:
                          SizedBox(
                            width: 42.w,
                            child: SvgPicture.asset(
                              Assets.SVG_Account_edite,
                              fit: BoxFit.scaleDown,
                            )    ,))):
                  Positioned(
                      right:
                      20.w,

                      bottom: 0,
                      top: 0,
                      child:
                      GestureDetector(
                          onTap: (){
                            if(shouldSave==false){
                              shouldSave=true;
                              setState((){});}
                          },
                          child:
                          SizedBox(
                            width: 42.w,
                            child: SvgPicture.asset(
                              Assets.SVG_Account_edite,
                              fit: BoxFit.scaleDown,
                            )    ,)))

                ])
    )
          ],
        ));
  }

  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
      TextAlign.right:TextAlign.left,
    );
  }

  _buildProfileImage()  {
    // File file;
    // base64Decode(profileLoadedTMP.userEntity.imageString64);
    //
    String decodedString=profileLoadedTMP.imageString64??"";



     final decodestring = base64Decode('${decodedString}'.split(',').last);
     Uint8List encodeedimg = decodestring;

    return
      GestureDetector(onTap: (){



        selectimage(context);

      },child:
      Center(
      child:

      Container(
          height: 183.r,
          width: 183.r,
          decoration: Styles.decotrationBoxStyled(
              radius: 183.r,
              backgroundColor: Color(0xffE8F5ED),
              innerOffset1: Offset(0, -1.42),
              innerblurRadius1: 1.42,
              innerShadawColor1: Color(0xffDCE9E1),
              innerOffset2: Offset(0, 1.42),
              innerblurRadius2: 1.42,
              innerShadawColor2: Color(0xffF1FFF7),
              dropblurRadius: 11.2,
              dropOffset: Offset(0, 5.6),
              dropShadawColor: Color(0xff2E312F).withOpacity(0.14)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(183.r),

            child:
           Image.memory(encodeedimg,fit: BoxFit.fill,)
                          // color: Styles.colorPrimary,

          )),
      ));
  }

  getStringValue(int index) {
    switch (index) {
      case 1:
        return S.of(context).english;
      case 2:
        return S.of(context).arabic;
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
  Future<CroppedFile?> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    CroppedFile?  xFile;


      if (pickedFile != null) {
        _image = pickedFile;
        pick = true;
        File file = File(
          _image.path,
        );

         xFile=   await ImageCropper().cropImage(
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
                toolbarTitle: S.of(context).cropper,
                toolbarColor: Styles.ColorBlueTurquoiseLite,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false),
            IOSUiSettings(
              title:  S.of(context).cropper ,
            )
          ],
        )   ;


      } else {
        print("S.of(context).noImageSelected");
      }

     return xFile;
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
                    toolbarTitle: S.of(context).cropper,
                    toolbarColor: Styles.ColorBlueTurquoiseLite,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.square,
                    lockAspectRatio: false),
                IOSUiSettings(
                  title: S.of(context).cropper,
                )
              ])) as File;

//           await file.length().then((newvalue) async {
//             if (newvalue <= 1024000)
// //wait for backend update APi
//             {
// //wait for backend update APi
//               loaded = false;
//               //}
//             } else {
//               Utils.showToast("Image size is bigger than 1MB");
//             }
//           });
        });
//                   else{
//                     // Utils.showToast("Image not changed");
//                     Utils.popNavigate(context);
//
//                   }
      } else {
        print('No image selected.');
      }
      Uint8List _bytes=await _image.readAsBytes();
      String decodedString = base64.encode(_bytes);
      profileLoadedTMP.imageString64=decodedString;
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
                      S.of(context).photolibrary,
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
                    S.of(context).camera,
                    style: TextStyle(
                      fontFamily: Styles.FontFamily,
                    ),
                  ),
                  onTap: () async {

                  CroppedFile? tmp = await  getImage();

                     if (CroppedFile == null) {
                      return;
                    }
                      Uint8List _bytes=await tmp!.readAsBytes();
                      String decodedString = base64.encode(_bytes);
                      profileLoadedTMP.imageString64=decodedString;
                  shouldSave=true;

                  setState(() {
                  });
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
