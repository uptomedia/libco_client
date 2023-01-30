import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/paymeny_method_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/app/state/appstate.dart';
import '../../../../../../core/shared_preferences_items.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../l10n/locale_provider.dart';
import '../../../../../../l10n/selected_provider.dart';
import '../../../../../data/remote/models/transfer_info_model.dart';
import '../../../../bloc/tranfer_info/transfer_info_cubit.dart';

class OrderDetailScreen extends AppStatefulWidget {

  OrderDetailScreen({Key? key});

  @override
  State<StatefulWidget> createState() => _OrderDetailScreenState();
}
late TransferInfoLoaded stateTmp;

class _OrderDetailScreenState extends StatefulWidgetState<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: SafeArea(
          child:
          Column(
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
                      Expanded(
                        child: Center(
                            child: _buildTitle(
                              S.of(context).transferInfo ,
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
              CommonSizes.vCustomSpace(42.h),
              Center(
                  child: Container(
                      width: 313.w,
                      child: _buildTitle(
                          S.of(context).payOutMethod,
                          Styles.textStyle.copyWith(
                              color: Styles.textBlackDarkColor,
                              fontSize: Styles.fontSize15,
                              fontWeight: FontWeight.w600)))),
              CommonSizes.vCustomSpace(20.h),
              Expanded(child:
              BlocConsumer<TransferInfoCubit,
                  TransferInfoState>(
                  listener: (BuildContext, transferInfo) {
                    if (transferInfo is TransferInfoLoaded) {

stateTmp=transferInfo;
                    }
                    if(transferInfo is TransferInfoFailure){
                      Utils.showToast("TransferInfoFailure");

                    }
                  }, builder: (context, transferInfo) {
                if (transferInfo is AddNewTransferInfoLoaded||
                    transferInfo is TransferInfoLoaded
                    ||transferInfo is TransferInfoInitial
                    ||transferInfo is TransferInfoFailure)
                  return _buildDetails(stateTmp);
                return CircularProgressIndicator();
              }))
             ,

              CommonSizes.vCustomSpace(33.h),
              _buildNextBtn(),
              CommonSizes.vCustomSpace(85.h),


            ],
          )

      ),

    );
  }
@override
initState(){

  BlocProvider.of<TransferInfoCubit>(context).getTransferInfo(
      uid: Provider
          .of<SelectedProvider>(context, listen: false)
          .userEntity
          .uid??"");

  super.initState();
}
  _buildNextBtn() {
    return Center(
      child: CustomButton(
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

          // Utils.pushNewScreenWithRouteSettings(
          //     context,
          //     withNavBar: false,
          //     screen: PaymentMethodScreen(),
          // settings: RouteSettings(
          // name: RoutePaths.PaymentMethodScreen,
          // ));
          //
        },
      ),
    );
  }

  _buildDetails( TransferInfoLoaded stateTmp) {
    return

      Expanded(
          child: ListView.separated(
              itemBuilder: (BuildContext context, index) {
                return   Center(
                  child:

                  Container(
                    // height: 330.h,
                    width: 313.w,
                    padding:
                    EdgeInsets.only(left: 26.w, right: 12.w, top: 16.h, bottom: 26.h),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: Container(
                                height: 30.r,
                                width: 30.r,
                                // padding: EdgeInsets.all(8.w),
                                decoration: Styles.decotrationBoxStyledWithGradient(
                                    radius: 54.r,
                                    backgroundColor1: Color(0xff1B895A),
                                    backgroundColor2: Color(0xff26BF7D),
                                    innerOffset1: Offset(0, 2.43),
                                    innerblurRadius1: 2.43,
                                    innerShadawColor1: Color(0xff27C782),
                                    innerOffset2: Offset(0, -2.43),
                                    innerblurRadius2: 2.43,
                                    innerShadawColor2: Color(0xff198155),
                                    dropblurRadius: 14.4,
                                    dropOffset: Offset(0, 7.2),
                                    dropShadawColor:
                                    Color(0xff07221648).withOpacity(0.282)),
                              ),
                            )
                          ],
                        ),
                        CommonSizes.vCustomSpace(16),
                        _buildRowInfo("Deleviery option name", stateTmp.tranferList[index].userName??""),
                        CommonSizes.vCustomSpace(21),
                        _buildRowInfo("Receive amount",stateTmp.tranferList[index].receiveAmount.toString()),
                        CommonSizes.vCustomSpace(21),
                        _buildRowInfo("Exchange rate", stateTmp.tranferList[index].exchangeRate.toString()),
                        CommonSizes.vCustomSpace(21),
                        _buildRowInfo("Payment currency", stateTmp.tranferList[index].paymentCurrency.toString()),
                        CommonSizes.vCustomSpace(21),
                        _buildRowInfo("Receive country", stateTmp.tranferList[index].recieveCurrency.toString()),
                        CommonSizes.vCustomSpace(21),
                        _buildRowInfo("Send amount", stateTmp.tranferList[index].sendAmount.toString() ),
                        CommonSizes.vCustomSpace(21),
                        _buildRowInfo("Total receive amount",stateTmp.tranferList[index].totalRecieveAmount.toString()),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, index) =>
                  CommonSizes.vCustomSpace(28.h),
              itemCount: stateTmp.tranferList.length));


  }

  _buildRowInfo(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(
            text1,
            Styles.fontStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Styles.fontSize12,
                color: Styles.textBlackDarkColor)),
        _buildTitle(
            text2,
            Styles.fontStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Styles.fontSize12,
                color: Styles.textBlackDarkColor)),
      ],
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
