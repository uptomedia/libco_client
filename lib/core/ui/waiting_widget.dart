import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter/material.dart';

class WaitingWidget extends AppStatelessWidget {
  WaitingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Styles.colorPrimary,
      ),
    );
  }
}
