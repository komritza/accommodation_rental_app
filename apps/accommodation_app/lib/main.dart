import 'package:accommodation_app/config/app_environment.dart';
import 'package:accommodation_app/router/app_router.dart';
import 'package:accommodation_app/screens/loading_screen.dart';
import 'package:accommodation_app/services/secure_token_storage.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_features/dependencies.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        tenantSlugProvider.overrideWith((ref) => tenantFromEnvironment()),
        apiClientProvider.overrideWith(
          (ref) => createApiClient(
            baseUrl: apiBaseUrl,
            tenant: ref.watch(tenantSlugProvider),
          ),
        ),
        tokenStorageProvider.overrideWithValue(
          SecureTokenStorage(const FlutterSecureStorage()),
        ),
      ],
      child: const AccommodationApp(),
    ),
  );
}

class AccommodationApp extends ConsumerWidget {
  const AccommodationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runtimeConfig = ref.watch(runtimeConfigProvider);

    return runtimeConfig.when(
      loading: () => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      ),
      error: (error, stackTrace) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _RuntimeConfigErrorScreen(
          message: error is RuntimeConfigLoadException
              ? error.toString()
              : 'Unable to load the accommodation configuration.',
          onRetry: () => ref.invalidate(runtimeConfigProvider),
        ),
      ),
      data: (config) => MaterialApp.router(
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
        routerConfig: ref.watch(appRouterProvider),
      ),
    );
  }
}

class _RuntimeConfigErrorScreen extends StatelessWidget {
  const _RuntimeConfigErrorScreen({
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
