import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/domain/usecase/add_payment_card_usecase.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../../app/sl.dart';
import '../../base/base_cubit.dart';

class PaymentViewModel extends BaseCubit
    implements PaymentViewModelInput, PaymentViewModelOutput {
  static PaymentViewModel get(context) => BlocProvider.of(context);

  final AddPaymentCardUseCase _addPaymentCardUseCase =
      sl<AddPaymentCardUseCase>();

  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpirationDateController =
      TextEditingController();

  Future<void> addCard() async {
    emit(LoadingState(displayType: DisplayType.popUpDialog));
    await _addPaymentCardUseCase(
      AddPaymentCardUseCaseInput(
        userId: DataIntent.getUser().uid,
        cardName: _cardNameController.text.trim(),
        cardNumber: _cardNumberController.text.trim(),
        cardExpirationDate:
            _cardExpirationDateController.text.trim().padLeft(4, '0'),
      ),
    ).then(
      (value) {
        value.fold(
          (l) {
            emit(
              ErrorState(
                failure: l,
                displayType: DisplayType.popUpDialog,
              ),
            );
          },
          (r) {
            _cardNameController.clear();
            _cardNumberController.clear();
            _cardExpirationDateController.clear();
            emit(SuccessState('Card Added Successfully'));
          },
        );
      },
    );
  }

  @override
  void start() {}

  @override
  TextEditingController get getCardNameController => _cardNameController;

  @override
  TextEditingController get getCardNumberController => _cardNumberController;

  @override
  TextEditingController get getCardExpirationDateController =>
      _cardExpirationDateController;
}

abstract class PaymentViewModelInput {}

abstract class PaymentViewModelOutput {
  TextEditingController get getCardNameController;

  TextEditingController get getCardNumberController;

  TextEditingController get getCardExpirationDateController;
}
