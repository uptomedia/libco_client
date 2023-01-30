import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'enums.dart';

/// Helper function to get device screen type according to device orientation and screen size
DeviceScreenType getDeviceScreenType(MediaQueryData mediaQueryData) {
  var orientation = mediaQueryData.orientation;

  double deviceWidth = 0;

  if (orientation == Orientation.landscape)
    deviceWidth = mediaQueryData.size.height;
  else
    deviceWidth = mediaQueryData.size.width;

  if (deviceWidth > 950) return DeviceScreenType.Desktop;

  if (deviceWidth > 600) return DeviceScreenType.Tablet;

  return DeviceScreenType.Mobile;
}

devLog(String log) {
  if (!kReleaseMode) print(log);
}
