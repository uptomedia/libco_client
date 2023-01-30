import 'dart:collection';

import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/bloc/currency_rate/currency_rate_cubit.dart';
import 'package:chegg/features/presentation/bloc/money_provider/money_provider_cubit.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/paymeny_method_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/app/state/appstate.dart';
import '../../../../../../core/shared_preferences_items.dart';
import '../../../../../../core/ui/custom_textfield.dart';
import '../../../../../../core/ui/widget/LILA/custom_drop_down.dart';
import '../../../../../../core/validators/validators.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../l10n/locale_provider.dart';
import '../../../../../../l10n/selected_provider.dart';
import '../../../../../data/remote/models/countrys_rate_model.dart';
import '../../../../../data/remote/models/transfer_info_model.dart';
import '../../../../../domain/entities/provider_entity.dart';

class TarnsferInfoScreen extends AppStatefulWidget {
  ProviderEntity providerEntity;

  TarnsferInfoScreen({required this.providerEntity, Key? key});

  @override
  State<StatefulWidget> createState() => _TarnsferInfoScreenState();
}

class _TarnsferInfoScreenState extends StatefulWidgetState<TarnsferInfoScreen> {
  @override
  initState() {
    BlocProvider.of<MoneyProviderCubit>(context)
        .getCountry(providerEntity: widget.providerEntity);
    _destationAmountController.text="0";
    _sourceAmountController.text="0";
    super.initState();
  }

  final _sourceAmountController = TextEditingController();
  final _destationAmountController = TextEditingController();
  FocusNode _sourceAmountFocusNode = FocusNode();
  FocusNode _destationAmountFocusNode = FocusNode();
  TransferInfo transferInfo=new TransferInfo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonSizes.vCustomSpace(16.2),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              height: 42.r,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                        child: Container(
                            height: 42.r,
                            width: 42.r,
                            child: Icon(Icons.arrow_back))),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Center(
                      child: _buildTitle(
                      S.of(context).transferInfo ,
                          Styles.textStyle.copyWith(
                              color: Styles.textBlackDarkColor,
                              fontSize: Styles.fontSize20,
                              fontWeight: FontWeight.w600))),
                  SizedBox(
                    child: Container(
                      height: 42.r,
                      width: 42.r,
                    ),
                  ),
                ],
              )),
          CommonSizes.vCustomSpace(42.h),
          Center(
              child: Container(
                  width: 313.w,
                  child: _buildTitle(
                S.of(context).destinationCountry ,
                      Styles.textStyle.copyWith(
                          color: Styles.textBlackDarkColor,
                          fontSize: Styles.fontSize15,
                          fontWeight: FontWeight.w600)))),
          CommonSizes.vCustomSpace(20.h),
          BlocConsumer<MoneyProviderCubit, MoneyProviderState>(
              listener: (BuildContext, moneyProvider) {
            if (moneyProvider is UpdateProviderLoaded) {
              if(moneyProvider.countryList.length==0){

              }
              else {
                CountrySourceList = moneyProvider.countryList;

                _chosenValue = CountrySourceList.first;
                List<CountrysRatesModel> tmp = CountrySourceList;
                tmp = LinkedHashSet<CountrysRatesModel>.from(CountrySourceList)
                    .toList();

                CountryDestationList = _filterList(
                    tmp, _chosenValue!.dest!.name ?? "");
                _chosenValueDestion = _chosenValue;
              }
              if(BlocProvider.of<CurrencyRateCubit>(context).state is
              CurrencyRateInitial){
                BlocProvider.of<CurrencyRateCubit>(context)
                    .getCurrencyRate(
                    code:
                    _chosenValue!.source!.name??"USD");}
             }
          }, builder: (context, moneystate) {

            if (moneystate is UpdateProviderLoaded){
               if(CountrySourceList.length==0){
                return Center(child: Container(child:
                _buildTitle("No Data",Styles.textStyle.copyWith(
                    color: Styles.textBlackDarkColor,
                    fontSize: Styles.fontSize15,
                    fontWeight: FontWeight.w600))  )
                );
               }

              return
                Column(
                children: [
                  _buildCountrySourceList(),
                  CommonSizes.vCustomSpace(20.h),
                  _buildCountryDestationList(),
                  CommonSizes.vCustomSpace(20.h),
                ],
              );}
            return Center(child: CircularProgressIndicator());
          }),
          CommonSizes.vCustomSpace(20.h),
          _buildCurrencyConveter(),
          CommonSizes.vCustomSpace(23.h),
          Center(
              child: Container(
                  width: 313.w,
                  child: _buildTitle(
                      S.of(context).feeType ,
                      Styles.textStyle.copyWith(
                          color: Styles.textBlackDarkColor,
                          fontSize: Styles.fontSize15,
                          fontWeight: FontWeight.w600)))),
          CommonSizes.vCustomSpace(20.h),
          _buildSelectList(),
          CommonSizes.vCustomSpace(33.h),
          Center(
              child: Container(
                  width: 313.w,
                  child: _buildTitle(
                    S.of(context).promotionCode ,
                      Styles.textStyle.copyWith(
                          color: Styles.textBlackDarkColor,
                          fontSize: Styles.fontSize15,
                          fontWeight: FontWeight.w600)))),
          CommonSizes.vCustomSpace(20.h),
          _buildCobon(),
          CommonSizes.vCustomSpace(33.h),
          _buildNextBtn(),
          CommonSizes.vCustomSpace(85.h),
        ],
      ))),
    );
  }
double rateVal=0;
  _buildNextBtn() {
    return Center(
      child:
      CustomButton(
        text: "Next step",
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
            double totalRecieve = double.tryParse(
                _sourceAmountController.text ?? "0") ?? 0;
             transferInfo = new TransferInfo(
              userName: Provider
                  .of<SelectedProvider>(context, listen: false)
                  .userEntity
                  .name,
              UId:Provider
                  .of<SelectedProvider>(context, listen: false)
                  .userEntity
                  .uid,
              paymentCurrency: "",
              recieveCurrency: "",
              promotionCode: "",
              promotionRate: 0.0,
              receiveAmount: double.tryParse(
                  _sourceAmountController.text ?? "0"),
              exchangeRate: _chosenValueDestion!.rate ?? 0,
              sendAmount: double.tryParse(
                  _destationAmountController.text ?? "0"),
              totalRecieveAmount: (1 + rateVal) * totalRecieve,

            );
          }
          catch(e){
            print(e);
          }
Utils.pushNewScreenWithRouteSettings(
    context,
    withNavBar: false,
    screen: PaymentMethodScreen(transferInfo: transferInfo,),
    settings: RouteSettings(
      name: RoutePaths.PaymentMethodScreen,
    ));
          //
        },
      ),
    );
  }

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

  _buildCountrySourceList() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: CustomDropDown(
              menuBackground: Colors.white,
              initValue: _chosenValue,

              borderColor: Colors.transparent,
//  AppHelperFunctions.getStylesStatusButton(_selectedIndex),
              items: CountrySourceList,
              // widget.providerEntity.countryrate??[],
              title: "choose",
              valueChanged: (value) {
                // print(value.toString());
                // _selectedIndex = value;
                _chosenValue = CountrySourceList[value];
                BlocProvider.of<CurrencyRateCubit>(context)
                    .getCurrencyRate(
                    code:
                _chosenValue!.source!.name??"USD");
                _chosenValueDestion = _chosenValue;

                //
                // _spf.setString(SharedPreferencesKeys.LanguageCode,
                //     getLocal(_selectedIndex ).languageCode );
                // _spf.setInt(SharedPreferencesKeys.LanguageIndex,_selectedIndex  );
                //
                // final provider =
                // Provider.of<LocaleProvider>(context, listen: false);
                // provider.setLocale(getLocal(_selectedIndex ));
                setState(() {});
              },
              cornerRadius: 50,
              titleColor: Styles.FontColorBlack,
            )),
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
      ),
    );
  }

  _buildCountryDestationList() {

     List<CountrysRatesModel> tmp=CountrySourceList;
    tmp=  LinkedHashSet<CountrysRatesModel>.from(CountrySourceList).toList();

    CountryDestationList = _filterList(
        tmp, _chosenValue!.dest!.name ?? "");
    _chosenValueDestion=_chosenValue;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child:
                CustomDropDown(
              menuBackground: Colors.white,
              initValue: _chosenValue,

              borderColor: Colors.transparent,
//  AppHelperFunctions.getStylesStatusButton(_selectedIndex),
              items: CountryDestationList,
              // widget.providerEntity.countryrate??[],
              title: "choose",
              valueChanged: (value) {

                _chosenValueDestion = CountryDestationList[value];

                setState(() {});
              },
              cornerRadius: 50,
              titleColor: Styles.FontColorBlack,
            )),
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
      ),
    );
  }

  _buildSelectList() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: _buildTitle(
                    S.of(context).select,
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: Styles.fontSize16,
                        color: Styles.textBlackColor))),
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
      ),
    );
  }

  _buildCobon() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: _buildTitle(
                  S.of(context).select,
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: Styles.fontSize16,
                        color: Styles.textBlackColor))),
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
      ),
    );
  }

  _buildCurrencyConveter() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(),
                ),
                _buildTitle(
                S.of(context).amountInJod ,
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Styles.fontSize12,
                        color: Styles.textBlackColor)),
                SizedBox(width: 90.w),
                _buildTitle(
                   S.of(context).amountInCountry,
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Styles.fontSize12,
                        color: Styles.textBlackColor)),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          CommonSizes.vCustomSpace(8.h),
          Container(
            height: 74.h,
            width: 313.w,
            padding: EdgeInsets.all(10.w),
            decoration: Styles.decotrationBoxStyled(
                radius: 33.r,
                innerOffset1: Offset(0, 6.08),
                innerblurRadius1: 6.08,
                innerShadawColor1: Color(0xffF0FDF5),
                innerOffset2: Offset(0, -6.08),
                innerblurRadius2: 6.08,
                innerShadawColor2: Color(0xffDEEAE3),
                dropblurRadius: 51.6,
                dropOffset: Offset(0, 25.8),
                dropShadawColor: Color(0xff2E312F1F).withOpacity(0.121)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  height: 53.h,
                  decoration: BoxDecoration(
                    color: Color(0xff21A86E).withOpacity(0.22),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.r),
                      topRight: Radius.circular(22.r),
                      bottomLeft: Radius.circular(22.r),
                      bottomRight: Radius.circular(22.r),
                    ),
                  ),
                  child: Center(
                      child: CustomTextField(
                    textAlignHorizntal: TextAlign.center,
                    controller: _sourceAmountController,
                    focusNode: _sourceAmountFocusNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (value){

                    },
                    onFieldSubmitted: (value) {
                      double val=double.tryParse(value??"0")??0;
                      double val1= rateVal??0;
                      _destationAmountController.text=(val*val1).toString();
                      setState(() {});

                    },
                    validator: (value) {
                      if (Validators.isNotEmptyString(value ?? '')) {
                        return null;
                      }
                      return S.of(context).isNotEmpty;
                    },
                    height: 53.h,

                    helperText: "Receive amount",
                    fontSize: Styles.fontSize11,

                    fontWeight: FontWeight.w600,
                    textColor: Styles.textWhiteColor,
                    radius: 0.r,
                    hasBorder: true,
                    keyboardType: TextInputType.number,
                    inputDecoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      counter: SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      hintStyle: Styles.fontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Styles.textWhiteColor,
                          fontSize: Styles.fontSize11),
                      hintText: "Receive amount",
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil().setSp(11),
                      ),
                    ),
                    // inputDecoration: ,
                    decoration: BoxDecoration(color: Colors.transparent),
                  )),
                )),
                SizedBox(
                  width: 37.w,
                  child: Center(
                      child: _buildTitle(
                        S.of(context).or ,
                          Styles.fontStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: Styles.fontSize14,
                              color: Styles.textBlackColor))),
                ),
    Expanded(
    child:
                BlocConsumer<CurrencyRateCubit,
                    CurrencyRateState>(
                    listener: (BuildContext, currencyRate) {
                      if (currencyRate is CurrencyRateLoaded) {
                      Map<String,dynamic> map=currencyRate.currencyRateModel.data!.toJson();
                      double rate=double.tryParse(map['USD'].toString())??0.0;
                      double sourceValue= double.tryParse(_sourceAmountController.text)??0.0;
                      double val=rate*sourceValue ;
                      rateVal=rate;
                      _chosenValueDestion!.rate!=rate??0;

                         _destationAmountController.text=val.toString();
                      setState(() {});

                        //
                         //     CountrySourceList, _chosenValue!.dest!.name ?? "");
                      }
                      if(currencyRate is CurrencyRateFailure){
                        _destationAmountController.text="0.0";
                      }
                    }, builder: (context, currencyRateState) {
                  if (currencyRateState is CurrencyRateLoaded
                      ||currencyRateState is CurrencyRateInitial||currencyRateState is CurrencyRateFailure)
                    return
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff21A86E).withOpacity(0.22),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22.r),
                              topRight: Radius.circular(22.r),
                              bottomLeft: Radius.circular(22.r),
                              bottomRight: Radius.circular(22.r),
                            )),
                        child: Center(
                            child: CustomTextField(
isEditable: false,
                              textAlignHorizntal: TextAlign.center,
                              controller: _destationAmountController,
                              focusNode: _destationAmountFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {},
                              validator: (value) {
                                if (Validators.isNotEmptyString(value ?? '')) {
                                  return null;
                                }
                                return S.of(context).isNotEmpty;
                              },
                              height: 53.h,

                              helperText: "Receive amount",
                              fontSize: Styles.fontSize11,

                              fontWeight: FontWeight.w600,
                              textColor: Styles.textWhiteColor,
                              radius: 0.r,
                              hasBorder: true,
                              keyboardType: TextInputType.number,
                              inputDecoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                counter: SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                                hintStyle: Styles.fontStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Styles.textWhiteColor,
                                    fontSize: Styles.fontSize11),
                                hintText: "Send amount",
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: ScreenUtil().setSp(11),
                                ),
                              ),
                              // inputDecoration: ,
                              decoration: BoxDecoration(color: Colors.transparent),
                            )),
                      );
                  return CircularProgressIndicator();
                }),


                   ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
      TextAlign.right:TextAlign.left,    );
  }
}
