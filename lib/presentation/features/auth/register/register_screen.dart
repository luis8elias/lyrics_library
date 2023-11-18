import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/auth/register/providers/providers.dart';
import '/presentation/features/auth/shared/widgets/password_input.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/inputs.dart';
import '/presentation/widgets/providers.dart';
import '/utils/utils.dart';
import '/app/providers/providers.dart';
import 'widgets/register_button.dart';

class RegisterScreen extends ConsumerWidget{
  const RegisterScreen({super.key});

  static const String routeName = 'register';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionProv = ref.read(sessionProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: BackButtonWidget()
        ),
      ),
      body: SendProviderListener(
        provider: registerProvider,
        onError: (error) => SnackbarHelper.show(context,error),
        onSuccess: (model, message) {
          sessionProv.checkIfUserIsAuthenticated();
        },
        child: const _RegisterScreenUI()
      ),
    );
  }
}


class _RegisterScreenUI extends ConsumerWidget {
  const _RegisterScreenUI();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final prov = ref.watch(registerProvider);
    final theme = Theme.of(context);
    final lang = Lang.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.kPadding,
            right: Sizes.kPadding,
            bottom: Sizes.kPadding
          ),
          child: Column(
            children: [
              const SizedBox(
                height: Sizes.kPadding,
              ),
              Text(
                lang.registerScreen_title,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: Sizes.kPadding * 2,
              ),
              BasicInput(
                label: lang.registerScreen_nameInput,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => Validator.validateRequired(value!.trim()),
                onChanged: (value) => prov.updateFormModel((model) => model.copyWith(
                  name: value.trim()
                )),
              ),
              const SizedBox(
                height: Sizes.kPadding,
              ),
              BasicInput(
                label: lang.registerScreen_emailInput,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validator.validateEmail(value!.trim()),
                onChanged: (value) => prov.updateFormModel((model) => model.copyWith(
                  email: value.trim()
                )),
              ),
              const SizedBox(
                height: Sizes.kPadding,
              ),
              PasswordInput(
                label: lang.registerScreen_passwordInput,
                validator: (value) => Validator.validatePassword(value!.trim()),
                onChanged: (value) => prov.updateFormModel((model) => model.copyWith(
                  password: value.trim()
                )),
              ),
              const SizedBox(
                height: Sizes.kPadding,
              ),
              PasswordInput(
                label: lang.registerScreen_confrimPasswordInput,
                validator: (value) => Validator.validateConfirmPassword(value!.trim(), prov.formModel.password),
                onChanged: (value) => prov.updateFormModel((model) => model.copyWith(
                  confirmPassword: value.trim()
                )),
              ),
              const SizedBox(
                height: Sizes.kPadding * 2,
              ),
              const RegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}
