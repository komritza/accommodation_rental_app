import 'package:accommodation_core/accommodation_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_form_state.freezed.dart';

enum AuthMode { signIn, register }

@freezed
abstract class AuthFormState with _$AuthFormState {
  const factory AuthFormState({
    @Default(AuthMode.signIn) AuthMode mode,
    @Default(false) bool showValidationErrors,
    @Default(false) bool isSubmitting,
    ApiFailure? failure,
  }) = _AuthFormState;
}
