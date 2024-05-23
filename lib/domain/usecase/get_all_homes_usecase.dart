import 'package:dartz/dartz.dart';
import 'package:temp_house/domain/models/domain.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetAllHomesUseCase extends BaseUseCase<void, Stream<List<HomeModel>>> {
  final Repository _repository;

  GetAllHomesUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<HomeModel>>>> call(input) async {
    return _repository.getAllHomes();
  }
}

class GetAllHomesUseCaseInput {}
