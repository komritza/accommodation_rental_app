import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const xs = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class AppRadii {
  static const sm = 8.0;

  static const md = 12.0;

  static const smBorder = BorderRadius.all(Radius.circular(sm));
  static const mdBorder = BorderRadius.all(Radius.circular(md));
}

abstract final class AppBorderWidths {
  static const regular = 1.0;
  static const focused = 1.5;
}

abstract final class AppTypography {
  static const sizeSm = 14.0;
  static const sizeMd = 16.0;
  static const sizeLg = 20.0;
  static const sizeXl = 30.0;

  static const weightMedium = FontWeight.w500;
  static const weightSemibold = FontWeight.w600;
  static const weightExtraBold = FontWeight.w800;

  static const lineHeightTight = 1.2;
  static const lineHeightNormal = 1.4;
}

abstract final class AppIconSizes {
  static const status = 48.0;
}
