import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/routing/route_paths.dart';
import 'package:chegg/core/ui/widget/LILA/custom_button.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/transfer_info_screen.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/widgets/country_rate_card.dart';
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
import '../../../../bloc/currency_rate/currency_rate_cubit.dart';
import '../../../../bloc/exchange_currency/exchange_currency_cubit.dart';
import '../../../../bloc/money_provider/money_provider_cubit.dart';


class ExchangeMoneyScreen extends AppStatefulWidget {
  ExchangeMoneyScreen({Key? key});

  @override
  State<StatefulWidget> createState() => _ExchangeMoneyScreenState();
}

class _ExchangeMoneyScreenState extends StatefulWidgetState<ExchangeMoneyScreen> {

  @override
  void initState(){
    BlocProvider.of<ExchangeCurrencyCubit>(context).getExchangeCurrency(code: "");

    super.initState();

  }
  late MoneyProviderLoaded stateTmp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //
      //   BlocProvider.of<MoneyProviderCubit>(context).getMoneyProvider(uid:
      //   Constants.UID);
      // },child: Icon(Icons.add),),
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
                          S.of(context).moneyExchange,
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
           " 1 USD Dollar to other currency",
                Styles.textStyle.copyWith(
                    color: Styles.textBlackDarkColor,
                    fontSize: Styles.fontSize15,
                    fontWeight: FontWeight.w600)),
          ),
          CommonSizes.vCustomSpace(18.h),

         Container(
             width: 298.w,
             child:  BlocConsumer<ExchangeCurrencyCubit,ExchangeCurrencyState>(
              listener: (BuildContext, moneyProvider) {
                if (moneyProvider is ExchangeCurrencyLoaded) {


                }
              }, builder: (context, moneystate) {
            if (moneystate is ExchangeCurrencyLoaded)
              return
                ListView.separated(
                    shrinkWrap:true,
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
          CommonSizes.vCustomSpace(33.h),

         ],
      )),
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
