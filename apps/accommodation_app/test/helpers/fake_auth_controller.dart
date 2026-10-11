import 'dart:async';

import 'package:accommodation_app/providers/auth_providers.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'test_data.dart';

class FakeAuthController extends AuthController {
  FakeAuthController({
    this.initialUser,
    this.restoreError,
    this.loginResult,
    this.registerResult,
    this.delay,
  });

  final AuthUser? initialUser;
  final Object? restoreError;
  Either<ApiFailure, AuthUser>? loginResult;
  Either<ApiFailure, AuthUser>? registerResult;
  final Duration? delay;

  String? lastEmail;
  String? lastPassword;
  String? lastFirstName;
  String? lastLastName;
  String? lastLanguage;
  int loginCalls = 0;
  int registerCalls = 0;

  @override
  Future<AuthUser?> build() async {
    if (restoreError != null) {
      throw restoreError!;
    }

    return initialUser;
  }

  @override
  Future<Either<ApiFailure, AuthUser>> login({
    required String email,
    required String password,
    required String language,
  }) {
    loginCalls += 1;
    lastEmail = email;
    lastPassword = password;
    lastLanguage = language;
    return _complete(loginResult ?? const Right(testClient));
  }

  @override
  Future<Either<ApiFailure, AuthUser>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String language,
  }) {
    registerCalls += 1;
    lastEmail = email;
    lastPassword = password;
    lastFirstName = firstName;
    lastLastName = lastName;
    lastLanguage = language;
    return _complete(registerResult ?? const Right(testClient));
  }

  Future<Either<ApiFailure, AuthUser>> _complete(
    Either<ApiFailure, AuthUser> result,
  ) async {
    final resolved = delay == null
        ? result
        : await Future<Either<ApiFailure, AuthUser>>.delayed(
            delay!,
            () => result,
          );

    resolved.match((_) {}, (user) {
      state = AsyncData(user);
    });

    return resolved;
  }

  @override
  Future<Either<ApiFailure, bool>> logout() async {
    state = const AsyncData(null);
    return const Right(true);
  }
}

class LoadingAuthController extends AuthController {
  @override
  Future<AuthUser?> build() => Completer<AuthUser?>().future;
}
