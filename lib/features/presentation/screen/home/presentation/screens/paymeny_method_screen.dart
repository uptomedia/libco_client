import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/order_detail_screen.dart';
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
import '../../../../../data/remote/models/transfer_info_model.dart';
import '../../../../bloc/tranfer_info/transfer_info_cubit.dart';

class PaymentMethodScreen extends AppStatefulWidget {
  TransferInfo transferInfo;
  PaymentMethodScreen({required this.transferInfo,Key? key});

  @override
  State<StatefulWidget> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState
    extends StatefulWidgetState<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: SafeArea(
          child:

          BlocConsumer<TransferInfoCubit,
              TransferInfoState>(
              listener: (BuildContext, transferInfo) {
                if (transferInfo is AddNewTransferInfoLoaded) {
                  Utils.pushNewScreenWithRouteSettings(context,
                      withNavBar: false,
                      screen: OrderDetailScreen(

                      ),
                      settings: RouteSettings(
                        name: RoutePaths.OrderDetailScreen,
                      ));

                 }
                if(transferInfo is TransferInfoFailure){
                  Utils.showToast("TransferInfoFailure");

                }
              }, builder: (context, transferInfo) {
            if (transferInfo is AddNewTransferInfoLoaded||
            transferInfo is TransferInfoLoaded
                ||transferInfo is TransferInfoInitial
                ||transferInfo is TransferInfoFailure)
              return
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
                                      S.of(context).transferInfo,
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
                               S.of(context).payInMethod,
                                Styles.textStyle.copyWith(
                                    color: Styles.textBlackDarkColor,
                                    fontSize: Styles.fontSize15,
                                    fontWeight: FontWeight.w600)))),
                    CommonSizes.vCustomSpace(20.h),
                    _buildMethod(),
                    Expanded(child: Container()), _buildNextBtn(),
                    CommonSizes.vCustomSpace(85.h),

                    //  Expanded(
                    //   child: BlocConsumer<HomeBloc, HomeState>(
                    //       bloc: sl<HomeBloc>(),
                    //       listener: (context, HomeState state) {
                    //         print(state);
                    //         if (state is HomeError)
                    //           Utils.showToast(state.message ?? '');
                    //         else if (state is HomeCategoryLoaded) {}
                    //       },
                    //       builder: (context, state) {
                    //         return state is HomeError
                    //             ? Center(
                    //             child: ErrorWidgetScreen(
                    //               func: () {}, //_initStateFunc,
                    //               width: customWidth!,
                    //               height: customheight!,
                    //               message: state.message!,
                    //             ))
                    //             : state is HomeCategoryLoaded
                    //             ? Container():Container();
                    //         // HomeDishContent(
                    //         //     categories: Constants.categoriesData)
                    //         //     : HomeDishContent(
                    //         //     categories: Constants.categoriesData);
                    //       }),
                    // ),
                  ],
                );
            return Center(child:  CircularProgressIndicator());
          }),
       ),
    );
  }

  _buildNextBtn() {
    return Center(
      child: CustomButton(
        text: "Finish",
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

          BlocProvider.of<TransferInfoCubit>(context).addTransferInfo(
              note:widget.transferInfo);

          //
        },
      ),
    );
  }

  _buildMethod() {
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
            SizedBox(
              child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SvgPicture.asset(
                        Assets.SVG_Home_paymentMethode,
                        height: 24.r,
                        width: 24.r,
                        fit: BoxFit.scaleDown,
                      ))),
            ),
            SizedBox(
              width: 11.w,
            ),
            Expanded(
                child: _buildTitle(
                 S.of(context).select,
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Styles.fontSize13,
                        color: Styles.textBlackColor.withOpacity(0.44)))),
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


  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
      TextAlign.right:TextAlign.left,    );
  }
}
