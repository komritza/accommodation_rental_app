import 'package:accommodation_app/providers/auth_providers.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientHomePlaceholder extends ConsumerWidget {
  const ClientHomePlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return _RoleHomePlaceholder(
      title: l10n.clientHomePlaceholderTitle,
      user: ref.watch(authControllerProvider).value,
    );
  }
}

class HostHomePlaceholder extends ConsumerWidget {
  const HostHomePlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return _RoleHomePlaceholder(
      title: l10n.hostHomePlaceholderTitle,
      user: ref.watch(authControllerProvider).value,
    );
  }
}

class _RoleHomePlaceholder extends ConsumerWidget {
  const _RoleHomePlaceholder({required this.title, required this.user});

  final String title;
  final AuthUser? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final displayName = user == null
        ? ''
        : '${user!.firstName} ${user!.lastName}'.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
            child: Text(l10n.signOut),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (displayName.isNotEmpty)
                Text(l10n.signedInAs(displayName), textAlign: TextAlign.center),
              if (user != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.authenticatedRole(user!.role.name),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
