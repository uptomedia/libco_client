import 'dart:ui';

import 'package:chegg/core/configurations/styles.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  Future<T?> showElasticDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: _buildDialogTransitions,
    );
  }

  Widget _buildDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: animation,
          curve: const ElasticOutCurve(0.85),
          reverseCurve: Curves.easeOutBack,
        )),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * animation.value, sigmaY: 4 * animation.value),
          child: FadeTransition(
            child: child,
            opacity: animation,
          ),
        ),
      ),
    );
  }
}

void textFieldDialog(
    {required BuildContext context,
    int linesNumber = 1,
    required Function(String value) onAccept}) async {
  final messageController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              50,
            ),
          ),
        ),
        title: Text(
          "title",
          style: TextStyle(
            fontFamily: Styles.FontFamily,
            color: Colors.black,
            //fontSize: ScreenUtil().setSp(42),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Translation.of(context).confirm",
              style:
                  TextStyle(fontFamily: Styles.FontFamily, color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onAccept(messageController.text);
            },
          )
        ],
      );
    },
  );
}
