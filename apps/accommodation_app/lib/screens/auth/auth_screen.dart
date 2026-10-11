import 'package:accommodation_app/providers/runtime_config_providers.dart';
import 'package:accommodation_app/screens/auth/auth_error_mapper.dart';
import 'package:accommodation_app/screens/auth/auth_form_controller.dart';
import 'package:accommodation_app/screens/auth/auth_form_state.dart';
import 'package:accommodation_app/screens/auth/auth_layout_tokens.dart';
import 'package:accommodation_app/screens/auth/auth_validators.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _toggleMode() {
    ref.read(authFormControllerProvider.notifier).toggleMode();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      ref.read(authFormControllerProvider.notifier).showValidationErrors();
      return;
    }

    final notifier = ref.read(authFormControllerProvider.notifier);
    final language = Localizations.localeOf(context).languageCode;

    await notifier.submit(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      language: language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final tenantName = ref
        .watch(runtimeConfigProvider)
        .maybeWhen(data: (config) => config.name, orElse: () => '');
    final formState = ref.watch(authFormControllerProvider);
    final isRegister = formState.mode == AuthMode.register;
    final isSubmitting = formState.isSubmitting;

    final errorMessage = formState.failure == null
        ? null
        : localizedAuthError(l10n, formState.failure!);

    return _AuthPageLayout(
      wordmark: tenantName,
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          autovalidateMode: formState.showValidationErrors
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isRegister ? l10n.authCreateAccountTitle : l10n.authWelcomeBack,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                isRegister
                    ? l10n.authRegisterSubtitle
                    : l10n.authSignInSubtitle,
                style: textTheme.bodyLarge?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (isRegister) ...[
                _AuthTextField(
                  controller: _firstNameController,
                  focusNode: _firstNameFocus,
                  label: l10n.authFirstName,
                  enabled: !isSubmitting,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.givenName],
                  textCapitalization: TextCapitalization.words,
                  validator: (value) =>
                      validateRequiredName(value, l10n.authFirstNameRequired),
                  onSubmitted: (_) => _lastNameFocus.requestFocus(),
                ),
                const SizedBox(height: AppSpacing.md),
                _AuthTextField(
                  controller: _lastNameController,
                  focusNode: _lastNameFocus,
                  label: l10n.authLastName,
                  enabled: !isSubmitting,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.familyName],
                  textCapitalization: TextCapitalization.words,
                  validator: (value) =>
                      validateRequiredName(value, l10n.authLastNameRequired),
                  onSubmitted: (_) => _emailFocus.requestFocus(),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              _AuthTextField(
                controller: _emailController,
                focusNode: _emailFocus,
                label: l10n.authEmail,
                enabled: !isSubmitting,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                validator: (value) => validateEmail(value, l10n),
                onSubmitted: (_) => _passwordFocus.requestFocus(),
              ),
              const SizedBox(height: AppSpacing.md),
              _AuthTextField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                label: l10n.authPassword,
                enabled: !isSubmitting,
                obscureText: true,
                textInputAction: TextInputAction.done,
                autofillHints: [
                  isRegister
                      ? AutofillHints.newPassword
                      : AutofillHints.password,
                ],
                validator: (value) => validatePassword(value, l10n),
                onSubmitted: (_) => _submit(),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  errorMessage,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.stateError,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: isSubmitting ? null : _submit,
                child: Text(
                  isSubmitting
                      ? l10n.authPleaseWait
                      : isRegister
                      ? l10n.authRegister
                      : l10n.authSignIn,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _AuthModeSwitch(
                prompt: isRegister
                    ? l10n.authAlreadyHaveAccount
                    : l10n.authNewHere,
                actionLabel: isRegister
                    ? l10n.authSignIn
                    : l10n.authCreateAnAccount,
                onPressed: isSubmitting ? null : _toggleMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthPageLayout extends StatelessWidget {
  const _AuthPageLayout({required this.wordmark, required this.child});

  final String wordmark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AuthLayoutTokens.maxWidth,
            ),
            child: Padding(
              padding: AuthLayoutTokens.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (wordmark.isNotEmpty)
                    Text(
                      wordmark,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Center(child: child),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthModeSwitch extends StatelessWidget {
  const _AuthModeSwitch({
    required this.prompt,
    required this.actionLabel,
    required this.onPressed,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: textStyle?.copyWith(color: colors.textMuted)),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: colors.surfaceAction,
            textStyle: textStyle?.copyWith(
              fontWeight: AppTypography.weightSemibold,
            ),
          ),
          child: Text(actionLabel),
        ),
      ],
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.validator,
    required this.onSubmitted,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String? Function(String?) validator;
  final ValueChanged<String> onSubmitted;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          textCapitalization: textCapitalization,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          inputFormatters: keyboardType == TextInputType.emailAddress
              ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
              : null,
        ),
      ],
    );
  }
}
