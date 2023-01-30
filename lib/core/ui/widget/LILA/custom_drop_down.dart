import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/features/data/remote/models/country_model.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../features/data/remote/models/countrys_rate_model.dart';
import '../../../constants.dart';
import '../../../helper_functions.dart';

class CustomDropDown extends StatefulWidget {
  final List<CountrysRatesModel> items;
  final String title;
  final Color titleColor;
  final Color? hintColor;
  final FontWeight? titleWeight;
  final double? titleSize;
  final Color borderColor;
  final double cornerRadius;
  final Function valueChanged;
  final CountrysRatesModel? initValue;
   final Color menuBackground;
  final bool enabled;
  final bool hasBorder;

  final bool withIcon;

  const CustomDropDown(
      {Key? key,
      this.enabled: true,
      required this.items,
      this.withIcon = false,
      required this.title,
      required this.borderColor,
      required this.titleColor,
      this.cornerRadius = 25,
      required this.initValue,
      required this.valueChanged,
       required this.menuBackground,
      this.hasBorder = false,
      this.titleWeight,
      this.titleSize,
      this.hintColor})
      : super(key: key);

  @override
  _CustomDropDownState createState() {
    return _CustomDropDownState();
  }
}

class _CustomDropDownState extends State<CustomDropDown> {
  late CountrysRatesModel dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return  Container(
             decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.cornerRadius)),
                border: Border.all(
                    color: widget.hasBorder
                        ? Styles.colorPrimary
                        : widget.borderColor),
                color: widget.borderColor
                //   color: widget.borderColor,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: CommonSizes.BIG_LAYOUT_W_GAP.w,
                // ),
                Expanded(
                    child: new Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: widget.menuBackground,
                  ),
                  child: DropdownButton<CountrysRatesModel>(

                    key: widget.key,
                    value: widget.initValue,
                    hint: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: Styles.FontFamily,
                        color: widget.hintColor ?? Colors.black,
                        fontWeight: widget.titleWeight ?? FontWeight.w300,
                        fontSize: widget.titleSize ?? Styles.fontSize18,
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: Styles.FontFamily,
                        color: widget.titleColor,
                        fontWeight: widget.titleWeight ?? FontWeight.w500,
                        fontSize: widget.titleSize ?? Styles.fontSize14),
                    onChanged: widget.enabled
                        ? (CountrysRatesModel? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                            widget.valueChanged
                                .call(widget.items.indexOf(dropdownValue));
                          }
                        : null,
                    underline: Container(),
                    isExpanded: true,
                    icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),

                    items: widget.items
                        .map<DropdownMenuItem<CountrysRatesModel>>((CountrysRatesModel value) {
                      return DropdownMenuItem<CountrysRatesModel>(
                        key: ValueKey<CountrysRatesModel>(value),

                        value: value,
                        child: Row(

                            // direction: Axis.horizontal,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Styles.ColorWhite,
                                  //AppHelperFunctions.getStylesStatusButton(getIndex(value,code)),

                                  child:
                                  Flag.fromString(value.dest!.name==""?'us'
                                   : value.dest!.name??"us",
                                  ),                      ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                value.dest!.name??"",



                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                            ]),
                      );
                    }).toList(),
                  ),
                )),
              ],
            ),
          )
        ;
  }

 }
