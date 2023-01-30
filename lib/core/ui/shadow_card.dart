import 'package:chegg/core/configurations/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final EdgeInsetsGeometry? padding, margin;
  final Color? backGroundColor;
  final BorderRadius? borderRadius;

  const ShadowCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backGroundColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      padding: this.padding,
      margin: this.margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
          ),
        ],
        color: this.backGroundColor ?? Colors.white,
        borderRadius: this.borderRadius ??
            BorderRadius.circular(
              CommonSizes.BORDER_RADIUS_STANDARD,
            ),
      ),
      child: this.child,
    );
  }
}
