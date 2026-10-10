import 'package:accommodation_app/l10n/app_localizations.dart';
import 'package:accommodation_app/providers/auth_providers.dart';
import 'package:accommodation_app/providers/runtime_config_providers.dart';
import 'package:accommodation_app/theme/tenant_theme.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: AccommodationApp()));
}

class AccommodationApp extends ConsumerWidget {
  const AccommodationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runtimeConfig = ref.watch(runtimeConfigProvider);

    return runtimeConfig.when(
      loading: () => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _LoadingScreen(),
      ),
      error: (error, stackTrace) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _ErrorScreen(
          message: error is RuntimeConfigLoadException
              ? error.toString()
              : 'Unable to load the accommodation configuration.',
          onRetry: () => ref.invalidate(runtimeConfigProvider),
        ),
      ),
      data: (config) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        locale: Locale(config.defaultLocale.name),
        supportedLocales: config.locales
            .map((locale) => Locale(locale.name))
            .toList(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: buildTenantTheme(
          config.theme.light,
          brightness: Brightness.light,
        ),
        darkTheme: buildTenantTheme(
          config.theme.dark,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const _AuthGate(),
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Configuration could not be loaded',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthGate extends ConsumerWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () => const _LoadingScreen(),
      error: (error, stackTrace) => _SessionRestoreErrorScreen(
        message: error.toString(),
        onRetry: () => ref.invalidate(authControllerProvider),
      ),
      data: (user) {
        if (user == null) {
          return const _SignedOutScreen();
        }

        return _AuthenticatedScreen(user: user);
      },
    );
  }
}

class _SessionRestoreErrorScreen extends StatelessWidget {
  const _SessionRestoreErrorScreen({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Could not restore your session',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignedOutScreen extends StatelessWidget {
  const _SignedOutScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Sign-in screen will be implemented next.')),
    );
  }
}

class _AuthenticatedScreen extends StatelessWidget {
  const _AuthenticatedScreen({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome, ${user.firstName}')),
      body: Center(child: Text('Authenticated role: ${user.role.name}')),
    );
  }
}
