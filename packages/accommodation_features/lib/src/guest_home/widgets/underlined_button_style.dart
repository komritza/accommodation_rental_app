import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

ButtonStyle underlinedButtonStyle(
  BuildContext context, {
  required Color color,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  return TextButton.styleFrom(
    foregroundColor: color,
    padding: padding,
    minimumSize: const Size(0, AppButtonTokens.height),
    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: AppTypography.weightSemibold,
      decoration: TextDecoration.underline,
    ),
  );
}
