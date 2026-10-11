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
