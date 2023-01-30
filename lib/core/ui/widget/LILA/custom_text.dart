import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final bool withIcon;
  final IconData iconData;
  final AlignmentDirectional alignmentDirectional;

  const CustomText(
      {required this.text,
      required this.style,
      this.withIcon: false,
      this.iconData: Icons.search,
      this.textAlign: TextAlign.center,
      this.alignmentDirectional: AlignmentDirectional.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withIcon
        ? Container(

            // fit: BoxFit.scaleDown,
            alignment: alignmentDirectional,
            child: Row(
              children: [
                Text(
                  text,
                  maxLines: 5,
                  style: style,
                  textAlign: textAlign,
                ),
                Icon(
                  iconData,

                  /// color: ,
                ),
              ],
            ))
        : Container(

            // fit: BoxFit.scaleDown,
            alignment: alignmentDirectional,
            child: Text(
              text,
              maxLines: 5,
              style: style,
              textAlign: textAlign,
            ));
  }
}
