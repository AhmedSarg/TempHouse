import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/register_screen/states/register_states.dart';

import '../../../domain/models/enums.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../../common/data_intent/data_intent.dart';

class RegisterViewModel extends BaseCubit
    implements RegisterTenantViewModelInput, RegisterTenantViewModelOutput {

  static RegisterViewModel get(context) => BlocProvider.of(context);
  // final RegisterUseCase _registerOwnerUseCase;
  // RegisterViewModel(
  //     this._registerOwnerUseCase,
  //     );
  late UserType _registerType;
  UserType? _oldRegisterType;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _martialStatusController =
      TextEditingController();

  @override
  void start() {
    // _registerType = DataIntent.getSelection();
    // if (_registerType == UserType.tenant) {
    //   emit(RegisterTenantState());
    // } else {
    //   emit(RegisterOwnerState());
    // }
  }


  // set setRegisterType(UserType registerType) {
  //   _oldRegisterType = _registerType;
  //   _registerType = registerType;
  //   if (registerType == UserType.owner) {
  //     emit(RegisterOwnerState());
  //   } else {
  //     emit(RegisterTenantState());
  //
  //     emit(ContentState());
  //   }
  // }


  @override
  UserType get getRegisterType => _registerType;
  @override
  TextEditingController get getAgeController => _ageController;

  @override
  TextEditingController get getEmailController => _emailController;

  @override
  TextEditingController get getGenderController => _genderController;

  @override
  TextEditingController get getJobController => _jobController;

  @override
  TextEditingController get getMartialStatusController =>
      _martialStatusController;

  @override
  TextEditingController get getPasswordController => _passwordController;

  @override
  TextEditingController get getPhoneNumberController => _phoneNumberController;

  @override
  TextEditingController get getSalaryController => _salaryController;

  @override
  TextEditingController get getUsernameController => _usernameController;
}

abstract class RegisterTenantViewModelInput {}

abstract class RegisterTenantViewModelOutput {
  TextEditingController get getUsernameController;

  TextEditingController get getEmailController;

  TextEditingController get getPasswordController;

  TextEditingController get getPhoneNumberController;

  TextEditingController get getGenderController;

  TextEditingController get getJobController;

  TextEditingController get getSalaryController;

  TextEditingController get getAgeController;

  TextEditingController get getMartialStatusController;
}
