import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ChangeAccountInfoUseCase
    extends BaseUseCase<ChangeAccountInfoUseCaseInput, void> {
  final Repository _repository;

  ChangeAccountInfoUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(
      ChangeAccountInfoUseCaseInput input) async {
    return _repository.changeAccountInfo(
      userId: input.userId,
      emailChanged: input.emailChanged,
      email: input.email,
      phoneNumber: input.phoneNumber,
      pictureChanged: input.pictureChanged,
      picture: input.picture,
    );
  }
}

class ChangeAccountInfoUseCaseInput {
  final String userId;
  final bool emailChanged;
  final String email;
  final String phoneNumber;
  final bool pictureChanged;
  final File? picture;

  ChangeAccountInfoUseCaseInput({
    required this.userId,
    required this.emailChanged,
    required this.email,
    required this.phoneNumber,
    required this.pictureChanged,
    required this.picture,
  });
}
