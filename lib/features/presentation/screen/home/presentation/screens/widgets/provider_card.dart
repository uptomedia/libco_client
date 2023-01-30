import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/app/state/appstate.dart';
import '../../../../../../../core/configurations/styles.dart';
import '../../../../../../../core/shared_preferences_items.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../../l10n/locale_provider.dart';
import '../../../../../../../l10n/selected_provider.dart';
import '../../../../../../domain/entities/provider_entity.dart';


class ProviderCard extends StatefulWidget {
  ProviderEntity providerEntity;
  int index;
bool isSelected ;
  ProviderCard({
    required this.index,
    required this.providerEntity,this.isSelected:false, Key? key}) : super(key: key);

  @override
  State<ProviderCard> createState() => _ProviderCardState();
}

class _ProviderCardState extends State<ProviderCard> {



  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 29.w),
            child: Container(
              height: 127.h,
              width: 299.w,
              padding: EdgeInsets.symmetric(horizontal: 31.w),
              decoration:
              widget.index== Provider.of<SelectedProvider>(context, listen: false).index?
              Styles.decotrationBorderBoxStyled(
                  backgroundColor: Color(0xffE8F5ED),
                  radius: 33.r,
                  innerOffset1: Offset(0, 6.16),
                  innerblurRadius1: 616,
                  innerShadawColor1: Color(0xffEFFDF4),
                  innerOffset2: Offset(0, -6.16),
                  innerblurRadius2: 6.16,
                  innerShadawColor2: Color(0xffDFECE4),
                  dropblurRadius: 54.93,
                  dropOffset: Offset(0, 27.47),
                  dropShadawColor: Color(0xff2E312F1A).withOpacity(0.1035))
                :
              Styles.decotrationBoxStyled(
                  backgroundColor: Color(0xffE8F5ED),
                  radius: 33.r,
                  innerOffset1: Offset(0, 6.16),
                  innerblurRadius1: 616,
                  innerShadawColor1: Color(0xffEFFDF4),
                  innerOffset2: Offset(0, -6.16),
                  innerblurRadius2: 6.16,
                  innerShadawColor2: Color(0xffDFECE4),
                  dropblurRadius: 54.93,
                  dropOffset: Offset(0, 27.47),
                  dropShadawColor: Color(0xff2E312F1A).withOpacity(0.1035)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildTitle(
                      widget.providerEntity.name??"",
                      Styles.fontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: Styles.fontSize20,
                          color: Styles.textBlackDarkColor),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      height: 81.r,
                      width: 81.r,
                      // padding: EdgeInsets.all(8.w),
                      decoration:   Styles.decotrationBoxStyledWithGradient(
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
                      // child:
                      // ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child:
                      //     SvgPicture.asset(
                      //       Assets.SVG_Home_sendMoney,height: 51.r,width: 51.r,fit: BoxFit.scaleDown,
                      //     )
                      // )
                    ),
                  )
                ],
              ),
            ));
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
