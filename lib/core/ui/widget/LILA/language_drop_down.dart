import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/features/data/remote/models/country_model.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../features/data/remote/models/countrys_rate_model.dart';
import '../../../constants.dart';
import '../../../helper_functions.dart';

class LanguageDropDown extends StatefulWidget {
  final List<String> items;
  final String title;
  final Color titleColor;
  final Color? hintColor;
  final FontWeight? titleWeight;
  final double? titleSize;
  final Color borderColor;
  final double cornerRadius;
  final Function valueChanged;
  final String? initValue;
   final Color menuBackground;
  final bool enabled;
  final bool hasBorder;

  final bool withIcon;

  const LanguageDropDown(
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
  _LanguageDropDownState createState() {
    return _LanguageDropDownState();
  }
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  late String dropdownValue;

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
                  child: DropdownButton<String>(

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
                        ? (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                            widget.valueChanged
                                .call(widget.items.indexOf(dropdownValue));
                          }
                        : null,
                    underline: Container(),
                    isExpanded: true,

                    icon: Visibility (visible:false,
                        child: Icon(Icons.arrow_downward)),

                    items: widget.items
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        key: ValueKey<String>(value),

                        value: value,
                        child: Row(

                            // direction: Axis.horizontal,
                            children: [

                              SizedBox(
                                width:10.w,
                              ),
                              Text(
                                value??"",



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
