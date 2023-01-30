import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UiUtils {
  static void showAdaptiveDialog(BuildContext context,
      {Widget? title, Widget? content, List<Widget>? actions}) {
    showDialog(
        context: context,
        builder: (_) => Platform.isAndroid
            ? new AlertDialog(
                title: title,
                content: content,
                actions: actions,
              )
            : new CupertinoAlertDialog(
                title: title,
                content: content,
                actions: actions!,
              ));
  }
}
