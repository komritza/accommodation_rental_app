import 'package:accommodation_app/providers/auth_providers.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionRestoreErrorScreen extends ConsumerWidget {
  const SessionRestoreErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: AppIconSizes.status,
                color: colors.iconAction,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.sessionRestoreErrorTitle,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.sessionRestoreErrorMessage,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: () => ref.invalidate(authControllerProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
