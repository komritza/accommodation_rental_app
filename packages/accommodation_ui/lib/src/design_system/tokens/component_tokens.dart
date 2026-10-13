import 'package:flutter/widgets.dart';

import 'primitives.dart';

abstract final class AppInputTokens {
  static const contentPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: 14,
  );
}

abstract final class AppButtonTokens {
  static const height = 48.0;
  static const disabledOpacity = 0.6;
}

abstract final class AppIconButtonTokens {
  static const size = AppButtonTokens.height;
}

abstract final class AppChipTokens {
  static const height = AppButtonTokens.height;
  static const padding = EdgeInsets.symmetric(horizontal: AppSpacing.md);
}

abstract final class AppCalendarTokens {
  /// The largest a day cell grows; narrow screens shrink it to fit a week.
  static const daySize = AppButtonTokens.height;
  static const weekdayHeight = AppSpacing.lg;
  static const weeksPerMonth = 6;
}

abstract final class AppImageTokens {
  static const coverAspectRatio = 4 / 3;
}

abstract final class AppLayoutTokens {
  static const contentMaxWidth = 576.0;
}

abstract final class AppSheetTokens {
  static const heightFactor = 0.9;
}

abstract final class AppSizedBoxTokens {
  static const contentWidth = 88.0;
  static const contentHeight = 88.0;
}
