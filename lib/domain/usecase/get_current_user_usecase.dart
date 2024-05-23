import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetCurrentUserUseCase extends BaseUseCase<void, User?> {
  final Repository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(input) async {
    return repository.fetchCurrentUser();
  }
}

class GetCurrentUserUseCaseInput {}
