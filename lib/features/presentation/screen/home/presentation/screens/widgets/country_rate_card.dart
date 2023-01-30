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

class CountryExhangeCard extends StatelessWidget {

 String name;
 double val;
 CountryExhangeCard({
     this.name:"us",
    this.val:1,Key? key}) : super(key: key);



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
            Flag.fromString(name ==""?
            "us":name ??"us"
            )),
            SizedBox(width: 5.w,),
            _buildTitle(name,  Styles.fontStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Styles.fontSize12,
                color: Styles.textBlackDarkColor),),
            SizedBox(width: 5.w,),
            Expanded(child: Container()),
            Container(width: 30.w,
              child:
                  _buildTitle(
                   val.toString()??"1",
                    Styles.fontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: Styles.fontSize11,
                        color: Styles.textBlackDarkColor),

            )),
            SizedBox(width: 30.w,),


])
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
