import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/enums.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase extends BaseUseCase<RegisterUseCaseInput, void> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterUseCaseInput input) async {
    return _repository.register(
        uuid: input.uuid,
        username: input.username,
        email: input.email,
        phoneNumber: input.phoneNumber,
        gender: input.gender,
        job: input.job,
        salary: input.salary,
        age: input.age,
        martialStatus: input.martialStatus,
        registerType: input.registerType);
  }
}

class RegisterUseCaseInput {
  final String uuid;
  final String username;
  final String email;
  final String phoneNumber;
  final Gender gender;
  final String? job;
  final num? salary;
  final num age;
  final String martialStatus;
  final RegisterType registerType;

  RegisterUseCaseInput({
    required this.uuid,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.job,
    required this.salary,
    required this.age,
    required this.martialStatus,
    required this.registerType,
  });
}
