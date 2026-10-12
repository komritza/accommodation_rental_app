import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

class GuestSavedPlaceholder extends StatelessWidget {
  const GuestSavedPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.guestSavedPlaceholderTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            l10n.guestSavedPlaceholderMessage,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
