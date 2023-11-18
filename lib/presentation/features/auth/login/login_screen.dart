import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/auth/shared/widgets/password_input.dart';
import '/app/providers/providers.dart';
import '/presentation/features/auth/login/providers/providers.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/widgets.dart';
import '/config/config.dart';
import '/utils/utils.dart';
import 'widgets/widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const String routeName = '/auth/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final sessionProv = ref.read(sessionProvider);

    return SendProviderListener(
      provider: loginProvider,
      onError: (error) => SnackbarHelper.show(context,error),
      onSuccess: (model, message) {
        sessionProv.checkIfUserIsAuthenticated();
      },
      child: const LoginGoogleListener(),
    );

  }
}

class LoginGoogleListener extends ConsumerWidget {
  const LoginGoogleListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final sessionProv = ref.read(sessionProvider);

    return SendProviderListener(
      provider: loginGoogleProvider,
      onError: (error) => SnackbarHelper.show(context,error),
      onSuccess: (model, message) {
        sessionProv.checkIfUserIsAuthenticated();
      },
      child: const _LoginScreenUI(),
    );
  }
}

class _LoginScreenUI extends ConsumerWidget {
  const _LoginScreenUI();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final provider = ref.watch(loginProvider);
    final theme = Theme.of(context);
    final lang = Lang.of(context);
   
    return  Scaffold(
      body: SafeArea(  
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.kPadding,
              right: Sizes.kPadding,
              bottom: Sizes.kPadding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Sizes.kPadding * 2,
                ),
                Text(
                  lang.loginScreen_welcome,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: Sizes.kPadding * 3,
                ),
                BasicInput(
                  label: lang.loginScreen_emailInput,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validator.validateEmail(value!.trim()),
                  onChanged: (value) => provider.updateFormModel((model) => model.copyWith(
                    email: value.trim(),
                  )),
                ),
                const SizedBox(
                  height: Sizes.kPadding,
                ),
                PasswordInput(
                  label: lang.loginScreen_passwordInput,
                  onChanged: (value) => provider.updateFormModel((model)=> model.copyWith(
                    password: value,
                  )),
                  validator: (value) => Validator.validatePassword(value),
                ),
                const SizedBox(
                  height: Sizes.kPadding,
                ),
                const ForgotPasswordLink(),
                const SizedBox(
                  height: Sizes.kPadding,
                ),
                const StartButton(),
                const SizedBox(
                  height: Sizes.kPadding * 2,
                ),
                const LoginDivider(),
                const SizedBox(
                  height: Sizes.kPadding * 2,
                ),
                const LoginGoogleButton(),
                const SizedBox(
                  height: Sizes.kPadding,
                ),
                const RegisterLink()
              ],
            ),
          ),
        )
      )
    );
  }
}