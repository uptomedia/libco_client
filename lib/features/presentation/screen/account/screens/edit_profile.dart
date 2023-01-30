import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/ui/yolo_app_bar.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends AppStatefulWidget {
  EditProfileScreen();

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends StatefulWidgetState<EditProfileScreen> {
  SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();
  bool addressSelected = false;

  PlacesDetailsResponse? selectedLocation;

  AddressComponent? streetComponent;

  AddressComponent? streetNumberComponent;

  AddressComponent? zipCodeComponent;

  AddressComponent? countryComponent;

  AddressComponent? cityComponent;

  int countryId = 1;
  String newFullCountry = "";
  String newCountry = "";
  String newCity = "";
  String newZipCode = "";
  String newStreet = "";
  String newStreetNumber = "";

  String? addressErrorText;

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _dateOfBirthFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  IconData passwordIcon = Icons.visibility_off;
  IconData EditIcon = Icons.edit;
  bool isHiddenPassword = true;
  bool isEditabePassword = true;
  late SharedPreferences _spf;

  /// Text fields keys
  final _nameKey = new GlobalKey<FormFieldState<String>>();
  final _emailKey = new GlobalKey<FormFieldState<String>>();
  final _phoneKey = new GlobalKey<FormFieldState<String>>();
  final _addressKey = new GlobalKey<FormFieldState<String>>();
  final _lastNameKey = new GlobalKey<FormFieldState<String>>();
  final _userNameKey = new GlobalKey<FormFieldState<String>>();
  final _dateOfBirthKey = new GlobalKey<FormFieldState<String>>();
  final _passwordKey = new GlobalKey<FormFieldState<String>>();
  int _selectedIndex = 1;
  String _selectedDoc = "Male";
  late DateTime _selectedDate = DateTime.now();

  /// Text fields controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool loaded = true;

  var offset = DateTime.now().timeZoneOffset;
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Styles.ColorLiteGray));
  var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Colors.red));
  String rootKey = "ُEditProfile";
  late ValueKey nameKey,
      emailKey,
      phoneNumberKey,
      saveBtnKey,
      backKey,
      addressKey;

  setvalueKey() {
    nameKey = ValueKey<String>(rootKey + "name");
    emailKey = ValueKey<String>(rootKey + "email");
    phoneNumberKey = ValueKey<String>(rootKey + "phoneNumber");
    saveBtnKey = ValueKey<String>(rootKey + "saveBtn");
    backKey = ValueKey<String>(rootKey + "backKey");
    addressKey = ValueKey<String>(rootKey + "address");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initfAsync();

    setvalueKey();
  }

  @override
  Widget build(BuildContext context) {
    //_selectedDoc=getStringValue(widget.profile.gender!);

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          YoloAppBar(
            title: S.of(context).editProfile,
          ),
          // Expanded(
          //   child: BlocConsumer<AccountBloc, AccountState>(
          //       bloc: sl<AccountBloc>(),
          //       listener: (context, AccountState state) {
          //         // if (state is HomeLoading)
          //         //   LoadingOverlay.of(context).show();
          //         // else {
          //         //   LoadingOverlay.of(context).hide();
          //         print(state);
          //         if (state is AccountError)
          //           Utils.showToast(state.message ?? '');
          //         else if (state is EditInfoProfileLoaded) {
          //           loaded = true;
          //           sl<AccountBloc>().add(GetUserProfileEvent(
          //               profileParams: ProfileParams(
          //                   body: ProfileParamsBody(
          //                       token: _spf.getString(
          //                           SharedPreferencesKeys.TOKEN)))));
          //           _spf.setString(SharedPreferencesKeys.User_Image,
          //               state.editInfoProfileEntity!.result.imageUrl);
          //           _spf.setString(SharedPreferencesKeys.User_Name,
          //               state.editInfoProfileEntity!.result.firstName);
          //
          //           Utils.popNavigate(context);
          //         } else if (state is UpdateAppointmentLoaded) {
          //           {
          //             Utils.popNavigate(context, popsCount: 1);
          //           }
          //
          //           //         Utils.popNavigate(context);
          //         }
          //       },
          //       listenWhen: (prev, curre) {
          //         return prev != curre;
          //       },
          //       buildWhen: (prev, curre) {
          //         return prev != curre;
          //       },
          //       builder: (context, state) {
          //         return state is AccountError
          //             ? Center(
          //                 child: ErrorWidgetScreen(
          //                 func: _initStateFunc,
          //                 width: customWidth!,
          //                 height: customheight!,
          //                 message: state.message!,
          //               ))
          //             : loaded
          //                 //is GetAppointmentLoaded
          //                 ? GestureDetector(
          //                     onTap: () {
          //                       FocusScope.of(context)
          //                           .requestFocus(new FocusNode());
          //                     },
          //                     child: SingleChildScrollView(
          //                         padding: EdgeInsets.symmetric(
          //                           horizontal:
          //                               CommonSizes.BIG_LAYOUT_W_GAP.w,
          //                           vertical:
          //                               CommonSizes.TINY_LAYOUT_W_GAP.h,
          //                         ),
          //                         child: Column(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             CommonSizes.vBiggerSpace,
          //                             CustomText(
          //                               text: S
          //                                   .of(context)
          //                                   .personalInformation,
          //                               style: TextStyle(
          //                                   color: Styles.colorSecondary,
          //                                   fontSize: Styles.fontSize2,
          //                                   fontWeight: FontWeight.w700),
          //                               textAlign: TextAlign.start,
          //                               alignmentDirectional:
          //                                   AlignmentDirectional
          //                                       .centerStart,
          //                             ),
          //
          //                             CommonSizes.vBiggerSpace,
          //                             CustomText(
          //                               text: S.of(context).name + " *",
          //                               style: TextStyle(
          //                                   color: Styles.colorSecondary5,
          //                                   fontSize: Styles.fontSize3,
          //                                   fontWeight: FontWeight.w400),
          //                               textAlign: TextAlign.start,
          //                               alignmentDirectional:
          //                                   AlignmentDirectional
          //                                       .centerStart,
          //                             ),
          //                             CustomTextField(
          //                               key: nameKey,
          //                               labelText: "khkcvccxv",
          //                               obscureText: false,
          //                               maxLines: 1,
          //                               minLines: 1,
          //                               textAligntext: TextAlign.start,
          //                               primaryFieldColor:
          //                                   Styles.colorTertiary,
          //                               fontSize: Styles.fontSize3,
          //                               fontWeight: FontWeight.w400,
          //                               horizontalMargin: 0,
          //                               radius: 30,
          //                               showCounter: false,
          //                               padding: EdgeInsets.all(0),
          //                               hasBorder: false,
          //                               // textAlign: TextDirection.ltr,
          //                               helperText: S.of(context).name,
          //                               helperTextColor:
          //                                   Styles.colorSecondary5,
          //                               textColor: Styles.colorSecondary,
          //                               textKey: _nameKey,
          //                               focusNode: _nameFocusNode,
          //                               controller: _nameController,
          //                               textInputAction:
          //                                   TextInputAction.next,
          //                               keyboardType: TextInputType.text,
          //                               height: customheight! * 0.04,
          //                               onChanged: (value) {
          //                                 if (_nameKey.currentState!
          //                                     .validate()) {
          //                                   setState(() {});
          //                                 }
          //                               },
          //                               validator: (value) {
          //                                 if (Validators.isNotEmptyString(
          //                                     value!)) {
          //                                   if (!Validators
          //                                       .isValidFirstName(value!)) {
          //                                     return null;
          //                                   } else {
          //                                     // final snackBar = SnackBar(
          //                                     //     content:
          //                                     //     Text(S
          //                                     //         .of(context!)
          //                                     //         .nameContainText));
          //                                     //ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //                                     return S
          //                                         .of(context)
          //                                         .nameContainText;
          //                                     //return "";
          //
          //                                   }
          //                                 } else {
          //                                   // final snackBar = SnackBar(duration:Duration(milliseconds: 1000),
          //                                   //     content:
          //                                   //     Text(S
          //                                   //         .of(context!)
          //                                   //         .emptyFieldMessageError));
          //                                   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //                                   return S
          //                                       .of(context)
          //                                       .emptyFieldMessageError;
          //                                   //return " ";
          //                                 }
          //                                 // return S
          //                                 //     .of(context)
          //                                 //     .emptyFieldMessageError;
          //                               },
          //                               onFieldSubmitted: (value) {
          //                                 //  if (_nameKey.currentState!.validate()) {
          //                                 //    setState(() {});
          //                                 //  }
          //                               },
          //                             ),
          //                             //name
          //                           ],
          //                         )))
          //                 : WaitingWidget();
          //       }),
          // ),
        ],
          ),
        ));
  }



  //   }
  // }



  _initfAsync() async {
    _spf = await SharedPreferences.getInstance();
  }

  _initStateFunc() {
    Utils.popNavigate(context);
  }

  _extractComponents() {
    countryComponent = Utils.extractCountryComponent(selectedLocation!);
    if (countryComponent != null) {
      newCountry = countryComponent?.shortName ?? "";
      newFullCountry = countryComponent?.longName ?? "";
    }
    streetComponent = Utils.extractStreetComponent(selectedLocation!);
    if (streetComponent != null) newStreet = streetComponent?.longName ?? "";
    streetNumberComponent =
        Utils.extractStreetNumberComponent(selectedLocation!);
    if (streetNumberComponent != null)
      newStreetNumber = streetNumberComponent?.longName ?? "";
    cityComponent = Utils.extractCityComponent(selectedLocation!);
    if (cityComponent != null) {
      newCity = cityComponent?.longName ?? "";
    }
    zipCodeComponent = Utils.extractZipCodeComponent(selectedLocation!);
    if (zipCodeComponent != null) {
      newZipCode = zipCodeComponent?.longName ?? "";
    }
    // if (newCountry != "" && newStreet != "" && newStreetNumber != "" && newZipCode != "" )
    //   addressSelected = true;
    // else
    //   addressSelected = false;
    setState(() {});
  }
}
