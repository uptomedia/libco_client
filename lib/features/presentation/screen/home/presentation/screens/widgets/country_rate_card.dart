import 'package:country_picker/country_picker.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/app/state/appstate.dart';
import '../../../../../../../core/configurations/styles.dart';
import '../../../../../../../core/loaders/loading_overlay.dart';
import '../../../../../../../core/routing/route_paths.dart';
import '../../../../../../../core/shared_preferences_items.dart';
import '../../../../../../../core/ui/widget/LILA/custom_button.dart';
import '../../../../../../../core/utils.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../../l10n/locale_provider.dart';
import '../../../../../../../l10n/selected_provider.dart';
import '../../../../../../data/remote/models/country_model.dart';
import '../../../../../../data/remote/models/countrys_rate_model.dart';
import '../../../../../../domain/entities/provider_entity.dart';
import '../../../../../bloc/money_provider/money_provider_cubit.dart';
import '../detail_provider_screen.dart';


class CountryRateCard extends StatefulWidget {
  CountrysRatesModel countrysRatesModel;
  String providerId;
bool isSelected ;
  CountryRateCard({
    required this.providerId,
    required this.countrysRatesModel,this.isSelected:false, Key? key}) : super(key: key);

  @override
  State<CountryRateCard> createState() => _CountryRateCardState();
}

class _CountryRateCardState extends State<CountryRateCard> {



  @override
  Widget build(BuildContext context) {
    return

      Container(
        height: 50.h,
         padding: EdgeInsets.symmetric(horizontal: 12.w),
         decoration: Styles.decotrationBoxStyled(radius: 12.r),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 30.r,child:
            Flag.fromString(widget.countrysRatesModel.dest!.name==""?
            "us":widget.countrysRatesModel.dest!.name??"us"
            )),
SizedBox(width: 5.w,),
            Container(width: 30.w,
            child:
                _buildTitle(
                  widget.countrysRatesModel.source!.name??"us",
                  Styles.fontStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Styles.fontSize11,
                      color: Styles.textBlackDarkColor),

               ),
            ),
            SizedBox(width: 30.w,),
            SizedBox(width: 30.r,child:
            Flag.fromString(widget.countrysRatesModel.dest!.name==""?
            "us":widget.countrysRatesModel.dest!.name??"us")),
            SizedBox(width: 5.w,),

            Container(width: 30.w,
              child:
                  _buildTitle(
                    widget.countrysRatesModel.dest!.name??"",
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Styles.fontSize11,
                        color: Styles.textBlackDarkColor),

            )),
            SizedBox(width: 30.w,),

            Container(width: 50.w,
              child:
                  _buildTitle(
                    widget.countrysRatesModel.rate.toString()??"",
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Styles.fontSize11,
                        color: Styles.textBlackDarkColor),
                  )

            ),

            Expanded(child:

GestureDetector(
    onTap: (){
      showCustomMessage(context: context).then((value) =>
          Navigator.of(context).pop()
      );

    },
    child:
            Container(
              child: Icon(Icons.edit),
            )),),



            Expanded(child:GestureDetector(
                onTap: (){
                  showDeleteMessage(context: context).then((value) =>
                      Navigator.of(context).pop()
                  );

                },
                child: Container(
              child: Icon(Icons.remove_circle_outlined),
            ))
            )

           ],
        )
      );
//       InkWell(
//         onTap: () {
//           Utils.pushNewScreenWithRouteSettings(context,
//               withNavBar: false,
//               screen: DetailsProviderScreen(
// providerEntity: widget.providerEntity,
//               ),
//               settings: RouteSettings(
//                 name: RoutePaths.DetailsProviderScreen,
//               ));
//
//
//         },
//         child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 29.w),
//             child: Container(
//               height: 127.h,
//               width: 299.w,
//               padding: EdgeInsets.symmetric(horizontal: 31.w),
//               decoration: Styles.decotrationBoxStyled(
//                   backgroundColor: Color(0xffE8F5ED),
//                   radius: 33.r,
//                   innerOffset1: Offset(0, 6.16),
//                   innerblurRadius1: 616,
//                   innerShadawColor1: Color(0xffEFFDF4),
//                   innerOffset2: Offset(0, -6.16),
//                   innerblurRadius2: 6.16,
//                   innerShadawColor2: Color(0xffDFECE4),
//                   dropblurRadius: 54.93,
//                   dropOffset: Offset(0, 27.47),
//                   dropShadawColor: Color(0xff2E312F1A).withOpacity(0.1035)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: _buildTitle(
//                       widget.providerEntity.name??"",
//                       Styles.fontStyle.copyWith(
//                           fontWeight: FontWeight.w600,
//                           fontSize: Styles.fontSize20,
//                           color: Styles.textBlackDarkColor),
//                     ),
//                   ),
//                   SizedBox(
//                     child: Container(
//                       height: 81.r,
//                       width: 81.r,
//                       // padding: EdgeInsets.all(8.w),
//                       decoration: widget.isSelected?
//                     Styles.decotrationBoxStyled(): Styles.decotrationBoxStyledWithGradient(
//                           radius: 54.r,
//                           backgroundColor1: Color(0xff1B895A),
//                           backgroundColor2: Color(0xff26BF7D),
//                           innerOffset1: Offset(0, 2.43),
//                           innerblurRadius1: 2.43,
//                           innerShadawColor1: Color(0xff27C782),
//                           innerOffset2: Offset(0, -2.43),
//                           innerblurRadius2: 2.43,
//                           innerShadawColor2: Color(0xff198155),
//                           dropblurRadius: 14.4,
//                           dropOffset: Offset(0, 7.2),
//                           dropShadawColor:
//                               Color(0xff07221648).withOpacity(0.282)),
//                       // child:
//                       // ClipRRect(
//                       //     borderRadius: BorderRadius.circular(20),
//                       //     child:
//                       //     SvgPicture.asset(
//                       //       Assets.SVG_Home_sendMoney,height: 51.r,width: 51.r,fit: BoxFit.scaleDown,
//                       //     )
//                       // )
//                     ),
//                   )
//                 ],
//               ),
//             )));
  }

  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
      TextAlign.right:TextAlign.left,    );
  }

  Future<void> showCustomMessage ({

    required BuildContext context,

  }) async {
    String source=widget.countrysRatesModel.source!.name??"us";
    String dest=widget.countrysRatesModel.dest!.name??"us";

    _buildSaveBtn(BuildContext context, stfSetState) {
      return

        Center(
          child:
          CustomButton(
            text: "Save",
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


              try {

                if(source.compareTo("choose source")==0){
                  Utils.showToast("choose source");
                }else if(dest.compareTo("choose destination")==0){
                  Utils.showToast("choose destination");

                }
                else{


                  BlocProvider.of<MoneyProviderCubit>(context)
                      .updateCountryRateProvider(
                      subCollectionId:widget.providerId??"",
                      docId: widget.countrysRatesModel.countryRateId??"",
                      countrysRatesModel:
                  new  CountrysRatesModel(
                      source: CountryModel(name: source,imagePath: source),
                      dest: CountryModel(name: dest,imagePath: dest),
                      rate: 1.2
                  ));
                }
              }
              catch(e){
                print(e);
              }
              //
            },
          ),
        );
    }
    _buildCountryList(stfSetState){
      return Center(
          child: Container(
              height: 69.h,
              width: 313.w,
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
              child: GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                    exclude: <String>['KN', 'MF'],
                    favorite: <String>['SE'],
                    //Optional. Shows phone code before the country name.
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      source=country.countryCode;

                      stfSetState((){});
                      print('Select country: ${country.displayName}');
                    },
                    // Optional. Sets the theme for the country list picker.
                    countryListTheme: CountryListThemeData(
                      // Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      // Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                      // Optional. Styles the text in the search field
                      searchTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                child:
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child:
                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        source==""?    SizedBox(width: 30.r,child:
                        Flag.fromString(source)):SizedBox(),
                        SizedBox(width: 12.w,),
                        _buildTitle(source, Styles.textStyle.copyWith(
                            fontSize: Styles.fontSize12,
                            fontWeight: FontWeight.w400
                        )),

                      ],)),

              )
          ));
    }
    _buildCountryDestinationList(stfSetState){
      return Center(
          child: Container(
              height: 69.h,
              width: 313.w,
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
              GestureDetector(
                  child:
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          dest==""?SizedBox(width: 30.r,child:
                          Flag.fromString(dest)):SizedBox(),
                          SizedBox(width: 12.w,),
                          _buildTitle(dest, Styles.textStyle.copyWith(
                              fontSize: Styles.fontSize12,
                              fontWeight: FontWeight.w400
                          )),

                        ],)),
                  onTap: () {
                    showCountryPicker(

                      context: context,
                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                      exclude: <String>['KN', 'MF'],
                      favorite: <String>['SE'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        dest=country.countryCode;
                        stfSetState((){});
                        print('Select country: ${country.displayName}');
                      },
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );
                  })
          ));
    }


    await showDialog(
        context: context,

        builder: (context) =>

            StatefulBuilder(builder: (stcontext, stfSetState) {
              return

                AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.r))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0),
                    content: BlocConsumer<MoneyProviderCubit,MoneyProviderState>(

                        listener:(BuildContext context,MoneyProviderState moneyState) {

                          if (moneyState is MoneyProviderLoading)
                            LoadingOverlay.of(context).show();
                          else {
                            LoadingOverlay.of(context).hide();
                          }
                          if (moneyState is UpdateCountryRateLoaded){
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (BuildContext context, MoneyProviderState moneyState) {
                          if(moneyState is MoneyProviderLoading)
                            return CircularProgressIndicator();
                          return

                            Container(
                                width: 275.w,
                                // height: 300.h,
                                decoration: Styles.decotrationBoxStyled(radius: 33.r),
                                padding: EdgeInsets.symmetric(horizontal: 23.w,vertical: 15.h),
                                child:

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonSizes.vBigSpace,
                                    _buildTitle(
                                        "Edite Country to Provider",
                                        Styles.textStyle.copyWith(
                                            color: Styles.textBlackDarkColor,
                                            fontSize: Styles.fontSize20,
                                            fontWeight: FontWeight.w600)),
                                    CommonSizes.vBigSpace,

                                    Align(
                                        alignment:
                                        sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
                                        Alignment.centerRight:Alignment.centerLeft,

                                        child: _buildTitle(
                                            "Source",
                                            Styles.textStyle.copyWith(
                                                color: Styles.textBlackDarkColor,
                                                fontSize: Styles.fontSize20,
                                                fontWeight: FontWeight.w600))),
                                    CommonSizes.vSmallSpace,
                                    _buildCountryList(stfSetState),

                                    CommonSizes.vBigSpace,
                                    Align(
                                        alignment:
                                        sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
                                        Alignment.centerRight:Alignment.centerLeft,

                                        child: _buildTitle(
                                            "Destination",
                                            Styles.textStyle.copyWith(
                                                color: Styles.textBlackDarkColor,
                                                fontSize: Styles.fontSize20,
                                                fontWeight: FontWeight.w600))),
                                    CommonSizes.vSmallSpace,
                                    _buildCountryDestinationList(stfSetState),


                                     CommonSizes.vBigSpace,


                                    _buildSaveBtn(context,stfSetState),

                                    CommonSizes.vBigSpace,
                                  ],
                                )
                            )
                          ;})
                )  ;
            }
            )

    ) ;

  }
  Future<void> showDeleteMessage ({

    required BuildContext context,

  }) async {
    String source=widget.countrysRatesModel.source!.name??"us";
    String dest=widget.countrysRatesModel.dest!.name??"us";

    _buildSaveBtn(BuildContext context, stfSetState) {
      return

        Center(
          child:
          CustomButton(
            text: "delete",
            style: Styles.fontStyle.copyWith(
                color: Styles.textWhiteColor,

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





                  BlocProvider.of<MoneyProviderCubit>(context)
                      .deleteCountryRateProvider(
                      subCollectionId:widget.providerId??"",
                      docId: widget.countrysRatesModel.countryRateId??"",
                      countrysRatesModel:
                      new  CountrysRatesModel(
                          source: CountryModel(name: source,imagePath: source),
                          dest: CountryModel(name: dest,imagePath: dest),
                          rate: 1.2
                      ));



              //
            },
          ),
        );
    }
    _buildCountryList(stfSetState){
      return Center(
          child: Container(
              height: 69.h,
              width: 313.w,
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
              child: GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                    exclude: <String>['KN', 'MF'],
                    favorite: <String>['SE'],
                    //Optional. Shows phone code before the country name.
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      source=country.countryCode;

                      stfSetState((){});
                      print('Select country: ${country.displayName}');
                    },
                    // Optional. Sets the theme for the country list picker.
                    countryListTheme: CountryListThemeData(
                      // Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      // Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                      // Optional. Styles the text in the search field
                      searchTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                child:
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child:
                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        source==""?    SizedBox(width: 30.r,child:
                        Flag.fromString(source)):SizedBox(),
                        SizedBox(width: 12.w,),
                        _buildTitle(source, Styles.textStyle.copyWith(
                            fontSize: Styles.fontSize12,
                            fontWeight: FontWeight.w400
                        )),

                      ],)),

              )
          ));
    }
    _buildCountryDestinationList(stfSetState){
      return Center(
          child: Container(
              height: 69.h,
              width: 313.w,
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
              GestureDetector(
                  child:
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          dest==""?SizedBox(width: 30.r,child:
                          Flag.fromString(dest)):SizedBox(),
                          SizedBox(width: 12.w,),
                          _buildTitle(dest, Styles.textStyle.copyWith(
                              fontSize: Styles.fontSize12,
                              fontWeight: FontWeight.w400
                          )),

                        ],)),
                  onTap: () {
                    showCountryPicker(

                      context: context,
                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                      exclude: <String>['KN', 'MF'],
                      favorite: <String>['SE'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        dest=country.countryCode;
                        stfSetState((){});
                        print('Select country: ${country.displayName}');
                      },
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );
                  })
          ));
    }


    await showDialog(
        context: context,

        builder: (context) =>

            StatefulBuilder(builder: (stcontext, stfSetState) {
              return

                AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.r))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0),
                    content: BlocConsumer<MoneyProviderCubit,MoneyProviderState>(

                        listener:(BuildContext context,MoneyProviderState moneyState) {

                          if (moneyState is MoneyProviderLoading)
                            LoadingOverlay.of(context).show();
                          else {
                            LoadingOverlay.of(context).hide();
                          }
                          if (moneyState is DeleteCountryRateLoaded){
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (BuildContext context, MoneyProviderState moneyState) {
                          if(moneyState is MoneyProviderLoading)
                            return CircularProgressIndicator();
                          return

                            Container(
                                width: 275.w,
                                // height: 300.h,
                                decoration: Styles.decotrationBoxStyled(radius: 33.r),
                                padding: EdgeInsets.symmetric(horizontal: 23.w,vertical: 15.h),
                                child:

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonSizes.vBigSpace,
                                    _buildTitle(
                                        "Delete Country to Provider",
                                        Styles.textStyle.copyWith(
                                            color: Styles.textBlackDarkColor,
                                            fontSize: Styles.fontSize20,
                                            fontWeight: FontWeight.w600)),
                                    CommonSizes.vBigSpace,

                                    Align(
                                        alignment:
                                        sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
                                        Alignment.centerRight:Alignment.centerLeft,

                                        child: _buildTitle(
                                            "Source",
                                            Styles.textStyle.copyWith(
                                                color: Styles.textBlackDarkColor,
                                                fontSize: Styles.fontSize20,
                                                fontWeight: FontWeight.w600))),
                                    CommonSizes.vSmallSpace,
                                    _buildCountryList(stfSetState),

                                    CommonSizes.vBigSpace,
                                    Align(
                                        alignment:
                                        sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
                                        Alignment.centerRight:Alignment.centerLeft,

                                        child: _buildTitle(
                                            "Destination",
                                            Styles.textStyle.copyWith(
                                                color: Styles.textBlackDarkColor,
                                                fontSize: Styles.fontSize20,
                                                fontWeight: FontWeight.w600))),
                                    CommonSizes.vSmallSpace,
                                    _buildCountryDestinationList(stfSetState),


                                    CommonSizes.vBigSpace,


                                    _buildSaveBtn(context,stfSetState),

                                    CommonSizes.vBigSpace,
                                  ],
                                )
                            )
                          ;})
                )  ;
            }
            )

    ) ;

  }
}
