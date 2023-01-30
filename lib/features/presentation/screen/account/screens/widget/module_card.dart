import 'package:chegg/core/configurations/assets.dart';
import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:flutter/material.dart';

class ModuleCard extends AppStatefulWidget {
  late String title;
  late bool isSelected;
  final Function onPressed;

  late String imagePath;

  ModuleCard(
      {this.title: "",
      this.imagePath: Assets.PNG_NoImage,
      this.isSelected: false,
      required this.onPressed});

  @override
  State<StatefulWidget> createState() => _ModuleCardState();
}

class _ModuleCardState extends StatefulWidgetState<ModuleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        // padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: customheight! * 0.2,
                width: customWidth!,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Image.asset(widget.imagePath)
                // SvgPicture.asset(
                //     widget.imagePath,
                //   ),
                ),
            CommonSizes.vSmallerSpace,
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Styles.fontSize3,
              ),
              textAlign: TextAlign.center,
            ),
            CommonSizes.vSmallerSpace,
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
