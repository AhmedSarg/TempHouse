import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_cubit.dart';

class PaymentViewModel extends BaseCubit
    implements PaymentViewModelInput, PaymentViewModelOutput {

  static PaymentViewModel get(context) => BlocProvider.of(context);

  final TextEditingController _cardholderController = TextEditingController();
  final TextEditingController _cardNamberController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();


  @override
  void start() {}



  @override
  TextEditingController get getCardholderController  => _cardholderController;



  @override
  TextEditingController get getCardNamberController=> _cardNamberController;



  @override
  TextEditingController get getExpirationController=> _expirationController;
}

abstract class PaymentViewModelInput {}

abstract class PaymentViewModelOutput {
  TextEditingController get getCardholderController;

  TextEditingController get getCardNamberController;

  TextEditingController get getExpirationController;



}
