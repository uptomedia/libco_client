import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/data/remote/models/country_model.dart';
import 'package:chegg/features/domain/entities/exchange_currency_entity.dart';
import 'package:chegg/features/presentation/bloc/currency_rate/currency_rate_cubit.dart';
import 'package:chegg/features/presentation/bloc/exchange_currency/exchange_currency_cubit.dart';
import 'package:chegg/features/presentation/bloc/money_provider/money_provider_cubit.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/paymeny_method_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/widgets/country_rate_card.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/widgets/exchange_currency_card.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/app/state/appstate.dart';
import '../../../../../../core/loaders/loading_overlay.dart';
import '../../../../../../core/shared_preferences_items.dart';
import '../../../../../../core/ui/custom_textfield.dart';
import '../../../../../../core/ui/widget/LILA/custom_drop_down.dart';
import '../../../../../../core/ui/widget/LILA/show_dialog.dart';
import '../../../../../../core/validators/validators.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../l10n/locale_provider.dart';
import '../../../../../../l10n/selected_provider.dart';
import '../../../../../data/remote/models/countrys_rate_model.dart';
import '../../../../../data/remote/models/transfer_info_model.dart';
import '../../../../../domain/entities/provider_entity.dart';
import 'package:country_picker/country_picker.dart';
  class ExchangeTableScreen extends AppStatefulWidget {

  ExchangeTableScreen({  Key? key});

  @override
  State<StatefulWidget> createState() => _ExchangeTableScreenState();
}

class _ExchangeTableScreenState extends StatefulWidgetState<ExchangeTableScreen> {
  @override
  initState() {
    BlocProvider.of<ExchangeCurrencyCubit>(context).getExchangeCurrency(code: "");
    super.initState();
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
        floatingActionButton: FloatingActionButton(
          backgroundColor:Styles.colorPrimary,

          onPressed: () {
          showCustomMessage(context: context);

        },child: Icon(Icons.add,),),
      body: SafeArea(
          child: SingleChildScrollView(



 child:     Column(
    children: [
      CommonSizes.vCustomSpace(20.h),
      Container(

          padding: EdgeInsets.symmetric(horizontal: 29.w),
          height: 42.r,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                     // Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    child: Container(
                        height: 42.r,
                        width: 42.r,
                        // child: Icon(Icons.arrow_back)
                      ),
                  )),
              SizedBox(
                width: 14.w,
              ),
              Expanded(
                child: Center(
                    child: _buildTitle(
                         "Exchange Money",
                        Styles.textStyle.copyWith(
                            color: Styles.textBlackDarkColor,
                            fontSize: Styles.fontSize20,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(
                child: Container(
                  height: 42.r,
                  width: 42.r,
                ),
              ),
            ],
          )),
      CommonSizes.vCustomSpace(50.h),

       Center(
          child: Container(
              width: 313.w,
              height: 50.h,
              child: _buildTitle(
                  "exchange Table",
                  Styles.textStyle.copyWith(
                      color: Styles.textBlackDarkColor,
                      fontSize: Styles.fontSize15,
                      fontWeight: FontWeight.w600)))),
      CommonSizes.vCustomSpace(20.h),

   Container(
       height: 600.h,
       width: 313.w,

       // padding: EdgeInsets.symmetric(horizontal: 29.w),
       child:
      BlocConsumer<ExchangeCurrencyCubit,ExchangeCurrencyState>(
          listener: (BuildContext, moneyProvider) {
            if (moneyProvider is ExchangeCurrencyLoaded) {


          }
            }, builder: (context, moneystate) {
        if (moneystate is ExchangeCurrencyLoaded)
          return
     ListView.separated(
     itemBuilder: (BuildContext context, index) {
     return


       CountryExhangeCard(name:
       moneystate.exchangeCurrencyModel[index].name??"",
         val: moneystate.exchangeCurrencyModel[index].val??1,);
     },
     separatorBuilder: (BuildContext context, index) =>
     CommonSizes.vCustomSpace(28.h),
     itemCount: moneystate.exchangeCurrencyModel.length);



     return Center(child: CircularProgressIndicator());
     })),
       CommonSizes.vCustomSpace(85.h),
            ],
          )


     )

    ));


  }

  double rateVal=0;

  List<CountrysRatesModel> CountrySourceList = [];
  List<CountrysRatesModel> CountryDestationList = [];
  late CountrysRatesModel? _chosenValue;
  late CountrysRatesModel? _chosenValueDestion;

  List<CountrysRatesModel> _filterList(
      List<CountrysRatesModel> source, String key) {
    List<CountrysRatesModel> res = [];
    for (int i = 0; i < source.length; i++) {
      if (key.compareTo(source[i].dest!.name ?? "") == 0) {
        res.add(source[i]);
      }
    }

    return res;
  }

  final _nameController = TextEditingController();
   FocusNode _nameFocusNode = FocusNode();




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
    String source="choose source";

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
                }
                else{


                   BlocProvider.of<ExchangeCurrencyCubit>(context)
                       .addNewExchangeCurrencyUseCase(
                   new  ExchangeCurrencyEntity(
                    name: source,
                     val: 1.2
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
    _buildCountryList(stfSetState,fcontext){
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
                    context: fcontext,
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


  await showDialog(
      context: context,
      builder: (context) =>

          StatefulBuilder(builder: (stcontext, stfSetState) {
            return

               AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(33.r))),
                contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0),
                content: BlocConsumer<ExchangeCurrencyCubit,ExchangeCurrencyState>(

            listener:(BuildContext context,ExchangeCurrencyState moneyState) {

               if (moneyState is ExchangeCurrencyLoading)
                LoadingOverlay.of(context).show();
              else {
                 LoadingOverlay.of(context).hide();
               }
               if (moneyState is AddExchangeCurrencyLoaded){
                 Navigator.of(context).pop();
               }
            },
             builder: (BuildContext context, ExchangeCurrencyState moneyState) {
            if(moneyState is ExchangeCurrencyLoading)
            return CircularProgressIndicator();
            return

            Container(
            width: 275.w,
            // height: 300.h,
            decoration: Styles.decotrationBoxStyled(radius: 33.r),
            padding: EdgeInsets.symmetric(horizontal: 23.w,vertical: 15.h),
            child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CommonSizes.vBigSpace,
            _buildTitle(
            "add Country to exchange",
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
              _buildCountryList(stfSetState,stcontext),
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
