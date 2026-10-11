import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/auth_providers.dart';
import 'auth_form_state.dart';

part 'auth_form_controller.g.dart';

@riverpod
class AuthFormController extends _$AuthFormController {
  @override
  AuthFormState build() => const AuthFormState();

  void toggleMode() {
    if (state.isSubmitting) return;

    state = state.copyWith(
      mode: state.mode == AuthMode.signIn ? AuthMode.register : AuthMode.signIn,
      showValidationErrors: false,
      failure: null,
    );
  }

  void showValidationErrors() {
    if (state.showValidationErrors) return;

    state = state.copyWith(showValidationErrors: true);
  }

  Future<void> submit({
    required String email,
    required String password,
    required String language,
    String? firstName,
    String? lastName,
  }) async {
    if (state.isSubmitting) return;

    if (state.mode == AuthMode.register &&
        (firstName == null || lastName == null)) {
      state = state.copyWith(isSubmitting: false);
      return;
    }

    state = state.copyWith(isSubmitting: true, failure: null);

    try {
      final authController = ref.read(authControllerProvider.notifier);

      final result = state.mode == AuthMode.register
          ? await authController.register(
              email: email,
              password: password,
              firstName: firstName!.trim(),
              lastName: lastName!.trim(),
              language: language,
            )
          : await authController.login(
              email: email,
              password: password,
              language: language,
            );

      result.match((failure) {
        state = state.copyWith(failure: failure);
      }, (_) {});
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }
}
