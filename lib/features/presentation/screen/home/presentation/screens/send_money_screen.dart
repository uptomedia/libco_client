import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/transfer_info_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/widgets/provider_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/app/state/appstate.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/shared_preferences_items.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../l10n/locale_provider.dart';
import '../../../../../../l10n/selected_provider.dart';
import '../../../../bloc/money_provider/money_provider_cubit.dart';


class SendMoneyScreen extends AppStatefulWidget {
  SendMoneyScreen({Key? key});

  @override
  State<StatefulWidget> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends StatefulWidgetState<SendMoneyScreen> {

  @override
  void initState(){
    if(BlocProvider.of<MoneyProviderCubit>(context).state is MoneyProviderInitial)
      BlocProvider.of<MoneyProviderCubit>(context).getMoneyProvider(uid:
      Constants.UID);

    super.initState();

  }
  late MoneyProviderLoaded stateTmp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Icon(Icons.arrow_back)),
                      )),
                  SizedBox(
                    width: 14.w,
                  ),
                  Expanded(
                    child: Center(
                        child: _buildTitle(
                          S.of(context).sendMoney,
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
          CommonSizes.vCustomSpace(79.h),
          Center(
            child: _buildTitle(
           S.of(context).pleaseSelectTheServiceProvider,
                Styles.textStyle.copyWith(
                    color: Styles.textBlackDarkColor,
                    fontSize: Styles.fontSize15,
                    fontWeight: FontWeight.w600)),
          ),
          CommonSizes.vCustomSpace(18.h),

    BlocConsumer<MoneyProviderCubit,MoneyProviderState>(

        listener:(context,moneyState) {
          if (moneyState is MoneyProviderLoaded){
            stateTmp=moneyState;

          }
        },
        builder: (context,moneyState) {
      if (moneyState is MoneyProviderLoaded ||
          moneyState is UpdateProviderLoaded ) {
        return

          Expanded(
              child:stateTmp==null?Container(): ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    return ProviderCard(
                      providerEntity: stateTmp.notes[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, index) =>
                      CommonSizes.vCustomSpace(28.h),
                  itemCount: stateTmp.notes.length));
      }


      return Center(child: CircularProgressIndicator());
    }),
          CommonSizes.vCustomSpace(33.h),
          _buildNextBtn(),
          CommonSizes.vCustomSpace(85.h)

         ],
      )),
    );
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

if( Provider.of<SelectedProvider>(context, listen: false).isSelected) {
  Utils.pushNewScreenWithRouteSettings(context,
      withNavBar: false,
      screen: TarnsferInfoScreen(
          providerEntity:
          Provider
              .of<SelectedProvider>(context, listen: false)
              .providerEntity
      ),
      settings: RouteSettings(
        name: RoutePaths.TarnsferInfoScreen,
      ));
}else{
  Utils.showToast("please a provider");

}
          //
        },
      ),
    );
  }

  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?      TextAlign.right:TextAlign.left,
    );
  }
}
