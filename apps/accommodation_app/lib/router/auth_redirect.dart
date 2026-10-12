import 'package:accommodation_app/router/app_routes.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? resolveAuthRedirect({
  required AsyncValue<AuthUser?> auth,
  required String location,
}) {
  final atSplash = location == AppRoutePaths.splash;
  final atAuth = location == AppRoutePaths.auth;
  final atRestoreError = location == AppRoutePaths.sessionRestoreError;

  if (auth.isLoading && !auth.hasValue && !auth.hasError) {
    return atSplash ? null : AppRoutePaths.splash;
  }

  if (auth.hasError) {
    return atRestoreError ? null : AppRoutePaths.sessionRestoreError;
  }

  if (auth.isLoading) {
    return null;
  }

  final user = auth.value;
  if (user == null) {
    return atAuth ? null : AppRoutePaths.auth;
  }

  final home = user.role == UserRole.host
      ? AppRoutePaths.hostHome
      : AppRoutePaths.clientHome;

  if (atAuth || atSplash || atRestoreError) {
    return home;
  }

  if (_isWithin(location, AppRoutePaths.hostHome) &&
      user.role != UserRole.host) {
    return AppRoutePaths.clientHome;
  }

  if (_isWithin(location, AppRoutePaths.clientHome) &&
      user.role != UserRole.client) {
    return AppRoutePaths.hostHome;
  }

  return null;
}

bool _isWithin(String location, String areaRoot) {
  return location == areaRoot || location.startsWith('$areaRoot/');
}
