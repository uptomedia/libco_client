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

class AddNewProviderScreen extends AppStatefulWidget {

  AddNewProviderScreen({ Key? key});

  @override
  State<StatefulWidget> createState() => _AddNewProviderScreenState();
}

class _AddNewProviderScreenState extends StatefulWidgetState<AddNewProviderScreen> {
  @override
  initState() {

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
              child:
          BlocConsumer<MoneyProviderCubit, MoneyProviderState>(
              listener: (BuildContext, moneyProvider) {
                if (moneyProvider is AddMoneyProviderLoaded) {
                  Navigator.of(context).pop();

                }
                if (moneyProvider is MoneyProviderFailure ) {
 Utils.showError(context, "error");
                }
              }, builder: (context, moneystate) {
     return

      Column(
    children: [
      CommonSizes.vCustomSpace(20.h),
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
                         "New Provider",
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

     Align(
         alignment:

         sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?
            Alignment.centerRight:Alignment.centerLeft,


         child:
         Container(          padding: EdgeInsets.symmetric(horizontal: 29.w),
            child:
         Text(
        "Provider Name",
        style: Styles.textStyle.copyWith(
            color: Styles.textBlackDarkColor,
            fontSize: Styles.fontSize20,
            fontWeight: FontWeight.w600
            ),
            textAlign:
            sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.LanguageCode)=="ar"?      TextAlign.right:TextAlign.left,

         )  )),
    CommonSizes.vCustomSpace(20.h),
      _buildProviderName(),
    CommonSizes.vCustomSpace(70.h),

    _buildSaveBtn(),
    // CommonSizes.vCustomSpace(85.h),
    ],
    );

    })
          )      ),
    );
  }
double rateVal=0;
  _buildSaveBtn() {
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
            if(_nameController.text.isNotEmpty)
            BlocProvider.of<MoneyProviderCubit>(context).addMoneyProvider(
                note:new ProviderEntity(
                  name: _nameController.text,

                ));
          }
          catch(e){
            print(e);
          }
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

  final _nameController = TextEditingController();
   FocusNode _nameFocusNode = FocusNode();



  _buildProviderName() {
    return Container(
      // height: 69.h,
        padding: EdgeInsets.symmetric(horizontal: 29.w),

        child: CustomTextField(
          controller: _nameController,
           focusNode: _nameFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {},
          validator: (value) {
            if (Validators.isNotEmptyString(value ?? '')) {
              return null;
            }
            return S.of(context).isNotEmpty;
          },
          height: 69.h,
          helperText:  "new provider",
           radius: 33.r,
          hasBorder: true,
          keyboardType: TextInputType.text,
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
