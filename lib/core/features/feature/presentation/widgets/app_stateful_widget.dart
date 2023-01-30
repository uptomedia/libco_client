import 'package:chegg/core/configurations/styles.dart';
import 'package:flutter/material.dart';

import '../../../../enums.dart';
import '../../../../ui_helpers.dart';

abstract class AppStatefulWidget extends StatefulWidget {
  State<StatefulWidget> createState();
}

abstract class StatefulWidgetState<T extends AppStatefulWidget>
    extends State<T> {
  Orientation? _orientation;

  Orientation? get orientation {
    _orientation ??= MediaQuery.of(context).orientation;
    return _orientation;
  }

  DeviceScreenType? _deviceScreenType;
  DeviceScreenType? get deviceScreenType {
    _deviceScreenType ??= getDeviceScreenType(MediaQuery.of(context));
    return _deviceScreenType;
  }

  double? _topPadding;
  double? get topPadding {
    _topPadding ??= MediaQuery.of(context).padding.top;
    // devLog('sizes: top padding: $_topPadding');
    return _topPadding;
  }

  double? _bottomPadding;
  double? get bottomPadding {
    _bottomPadding ??= MediaQuery.of(context).padding.bottom;
    // devLog('sizes: bottom padding: $_bottomPadding');
    return _bottomPadding;
  }

  double? _customWidth;
  double? get customWidth {
    _customWidth = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    return _customWidth;
  }

  double? _customheight;

  double? get customheight {
    _customheight = MediaQuery.of(context).orientation != Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    return _customheight;
  }

  Size? _screenSize;
  Size? get screenSize {
    var currentOrientation = MediaQuery.of(context).orientation;
    if (_screenSize == null || currentOrientation != orientation) {
      _screenSize = MediaQuery.of(context).size;
      // devLog('sizes: : screenHeight: ${_screenSize?.height}');
      // devLog('sizes: screenWidth: ${_screenSize?.width}');

    }
    return _screenSize;
  }

  /// get screen Height without the notch and other device paddings
  double get screenHeight =>
      (screenSize?.height ?? 0) - (topPadding! + bottomPadding!);
  double get screenHeightWithoutNotch => (screenSize?.height ?? 0);
  // MediaQuery.of(context).orientation == Orientation.landscape ? screenSize?.width ?? 0 : screenSize?.height ?? 0;

  double get screenWidth => screenSize?.width ?? 0;
  // MediaQuery.of(context).orientation == Orientation.landscape ? screenSize?.height ?? 0 : screenSize?.width ?? 0;
  double get h => screenHeight * 0.001;

  double get w => screenWidth * 0.001;

  double get r => screenHeight * 0.001;
  // Fonts on demand
  TextStyle get regularFontStyle => Styles.fontStyle;

  TextStyle get mediumFontStyle => Styles.mediumFontStyle;

  TextStyle get semiBoldFontStyle => Styles.semiBoldFontStyle;

  TextStyle get primaryFontStyle =>
      Styles.fontStyle.copyWith(color: Styles.colorPrimary);

  TextStyle get secondaryFontStyle =>
      Styles.fontStyle.copyWith(color: Styles.colorSecondary);

  @override
  void dispose();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context);
}
