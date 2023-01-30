import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:chegg/core/ui/chegg_app_bar.dart';
import 'package:chegg/core/utils.dart';
import 'package:chegg/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:chegg/features/presentation/bloc/user/user_cubit.dart';
import 'package:chegg/features/presentation/screen/home/presentation/screens/widgets/provider_card.dart';
import 'package:chegg/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/app/state/appstate.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/routing/route_paths.dart';
import '../../../../../../core/shared_preferences_items.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../l10n/locale_provider.dart';
import '../../../../../../l10n/selected_provider.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../bloc/money_provider/money_provider_cubit.dart';
import 'add_new_provider_screen.dart';
import 'detail_provider_screen.dart';
import 'send_money_screen.dart';

class HomeScreen extends AppStatefulWidget {
  UserEntity? userEntity;

  HomeScreen({this.userEntity,Key? key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends StatefulWidgetState<HomeScreen> {
  @override
  void initState(){
    if(BlocProvider.of<UserCubit>(context).state is UserInitial ||BlocProvider.of<UserCubit>(context).state is UserSuccess)
      BlocProvider.of<UserCubit>(context).getUserProfile(uid:
      Constants.UID);
    // if(BlocProvider.of<MoneyProviderCubit>(context).state is MoneyProviderInitial)
      BlocProvider.of<MoneyProviderCubit>(context).getMoneyProvider(uid:
      Constants.UID);
    super.initState();

  }
    MoneyProviderLoaded? stateTmp;
  initPage(){
    BlocProvider.of<MoneyProviderCubit>(context).getMoneyProvider(uid:
    Constants.UID);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Styles.colorBackground,
      floatingActionButton: FloatingActionButton(
          backgroundColor:Styles.colorPrimary,
        onPressed: (){

        Utils.pushNewScreenWithRouteSettings(context,
            withNavBar: false,
            screen: AddNewProviderScreen(

            ),
            settings: RouteSettings(
              name: RoutePaths.AddNewProviderScreen,
            )).then((value) =>
        initPage(),);

      },child: Icon(Icons.add,),),

      body: SafeArea(
          child: Column(
        children: [
          CommonSizes.vCustomSpace(16.2),
          Container(
              height: 42.r,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  SizedBox(
                    child: Container(
                        height: 42.r,
                        width: 42.r,
                        decoration: Styles.decotrationBoxStyled(
                            radius: 42.r,
                            innerOffset1: Offset(0, -1.42),
                            innerblurRadius1: 1.42,
                            innerShadawColor1: Color(0xffDCE9E1),
                            innerOffset2: Offset(0, 1.42),
                            innerblurRadius2: 1.42,
                            innerShadawColor2: Color(0xffF1FFF7),
                            dropblurRadius: 11.2,
                            dropOffset: Offset(0, 5.6),
                            dropShadawColor:
                                Color(0xff2E312F).withOpacity(0.14)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          // child:
                          // SvgPicture.asset(
                          //               Assets.SVG_Cart,
                          //               // color: Styles.colorPrimary,
                          //             )
                        )),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(
                       S.of(context).welcom ,
                          Styles.textStyle.copyWith(
                              color: Styles.textBlackColor,
                              fontSize: Styles.fontSize11,
                              fontWeight: FontWeight.w400)),
                      BlocConsumer<UserCubit,UserState>(
                        bloc: BlocProvider.of<UserCubit>(context),
                                listener: (context, UserState state) {
                                print(state);
                                if (state is UserSuccess)
                                  Utils.showToast("UserSuccess");
                                else if (state is ProfileLoaded) {
                                  Provider.of<SelectedProvider>(context, listen: false).setUserEntity(state.userEntity);

                                }
                              },
                        builder: (context, userState) {
    if (userState is ProfileLoaded) {

    return _buildTitle(
    userState!.userEntity.name??"",
    Styles.textStyle.copyWith(
    color: Styles.textBlackColor,
    fontSize: Styles.fontSize15,
    fontWeight: FontWeight.w600));}
    return SizedBox(height: 10.h,width: 10.w,child: Center(child: CircularProgressIndicator()),);
    }

    )

          //



                    ],
                  )),
                  SizedBox(
                    child: Container(
                        height: 42.r,
                        width: 42.r,
                        child: Center(
                          child: Icon(Icons.search),
                        )),
                  ),
                ],
              )),
          CheggAppBar(
            title: "",
            withBack: false,
            tail: [
              Container(
                width: 144.w,
              ),

              Container(
                // color: Colors.red,

                width: 54.w,
              ),

//              InkWell(
//                  onTap: (){
// Utils.pushNavigateTo(context, false,RoutePaths.CartScreen
//
//      );
//                  },
//                  child:
//               Center(child:
//               Container(
//
//                   height:35.h,
//                   width: 37.1.w,
//                   // child:
//                   // ClipRRect(
//                   // borderRadius: BorderRadius.circular(20),
//                   child:
//
//                   Badge(
//                     badgeColor: Styles.colorSecondary,
//                     badgeContent: Text(
//                       Provider.of<CartManager>(context)
//                           .cartItems.length.toString(),
//                       style:
//                       Styles.boldTextStyle.copyWith(
//                           fontSize: Styles.fontSize15,color:Styles.ColorWhite ),
//                     ),
//
//                     showBadge: Provider.of<CartManager>(context)
//                         .cartItems.length >
//                         0,
//                     // badgeColor:isSelected? item.activeColorPrimary:item.inactiveColorPrimary??Styles.colorPrimary,
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         return Container(
//                             width:       26.w,
//                             height:  30.w,
//
//                             child:
//                             IconTheme(
//                               data: IconThemeData(
//                                   size: 30.w,
//                                     ),
//                               child: SvgPicture.asset(
//                                 Assets.SVG_Cart,
//                                 // color: Styles.colorPrimary,
//                               ) ,
//                             ));
//                       },
//                     ),
//                   )
//                   ),
//               )
//              ),
              Expanded(child: Container()),
            ],
          ),
          CommonSizes.vSmallSpace,
          CommonSizes.vCustomSpace(16.2),
           Center(
            child: _buildTitle(
                "Providers",
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
                if(stateTmp==null){

                }
                if (moneyState is MoneyProviderLoaded ||
                    moneyState is UpdateProviderLoaded ) {
                  return

                    Expanded(
                        child:stateTmp==null?Container(): ListView.separated(
                            itemBuilder: (BuildContext context, index) {
                              return
                                InkWell(
                                  onTap: () {
                                Utils.pushNewScreenWithRouteSettings(context,
                                    withNavBar: false,
                                    screen: DetailsProviderScreen(
                                      providerEntity: stateTmp!.notes[index],
                                    ),
                                    settings: RouteSettings(
                                      name: RoutePaths.DetailsProviderScreen,
                                    )).then((value) =>
                                    initPage(),);

                                    },
                                    child:
                                ProviderCard(
                                providerEntity: stateTmp!.notes[index],
                              ));
                            },
                            separatorBuilder: (BuildContext context, index) =>
                                CommonSizes.vCustomSpace(28.h),
                            itemCount: stateTmp!.notes.length));
                }


                return Center(child: CircularProgressIndicator());
              }),

        ],
      )),
    );
  }

  _buildTitle(String text, TextStyle style) {
    return Text(
      text,
      style: style,

      textAlign:
      sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
      TextAlign.right:TextAlign.left,
    );
  }


}
