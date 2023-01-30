import 'package:chegg/core/configurations/styles.dart';
import 'package:chegg/core/features/feature/presentation/widgets/app_stateful_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _FullScreenLoader();
      },
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends AppStatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullScreenLoaderState();
}

class _FullScreenLoaderState extends State<_FullScreenLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withAlpha(15),
      width: 300.0,
      height: 300.0,
      child: SpinKitThreeBounce(
        color: Styles.colorPrimary,
        size: 120.0,
      ),
    );
  }
}
