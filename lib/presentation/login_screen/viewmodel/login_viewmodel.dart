import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_cubit.dart';

class LoginViewModel extends BaseCubit
    implements LoginViewModelInput, LoginViewModelOutput {

  static LoginViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotPasswordEmailController = TextEditingController();
  final TextEditingController _resetPasswordController = TextEditingController();
  final TextEditingController _resetPasswordConfirmController = TextEditingController();

  @override
  void start() {}

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  TextEditingController get getResetPasswordController => _resetPasswordController;

  @override
  TextEditingController get getResetPasswordConfirmController => _resetPasswordConfirmController;

  @override
  TextEditingController get getForgotPasswordEmailController => _forgotPasswordEmailController;
}

abstract class LoginViewModelInput {}

abstract class LoginViewModelOutput {

  TextEditingController get getEmailController;

  TextEditingController get getPasswordController;

  TextEditingController get getForgotPasswordEmailController;

  TextEditingController get getResetPasswordController;

  TextEditingController get getResetPasswordConfirmController;
}
