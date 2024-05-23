import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddPaymentCardUseCase
    extends BaseUseCase<AddPaymentCardUseCaseInput, void> {
  final Repository repository;

  AddPaymentCardUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(input) async {
    return repository.addPaymentCard(
      userId: input.userId,
      cardName: input.cardName,
      cardNumber: input.cardNumber,
      cardExpirationDate: input.cardExpirationDate,
    );
  }
}

class AddPaymentCardUseCaseInput {
  final String userId;
  final String cardName;
  final String cardNumber;
  final String cardExpirationDate;

  AddPaymentCardUseCaseInput({
    required this.userId,
    required this.cardName,
    required this.cardNumber,
    required this.cardExpirationDate,
  });
}
