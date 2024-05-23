import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/domain.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetAllFavoritesUseCase extends BaseUseCase<GetAllFavoritesUseCaseInput,
    Stream<List<Future<HomeModel>>>> {
  final Repository repository;

  GetAllFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<List<Future<HomeModel>>>>> call(input) async {
    return repository.getAllFavorites(
      userId: input.userId,
    );
  }
}

class GetAllFavoritesUseCaseInput {
  final String userId;

  GetAllFavoritesUseCaseInput({
    required this.userId,
  });
}
