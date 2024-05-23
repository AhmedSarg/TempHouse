import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RemoveFromFavoritesUseCase
    extends BaseUseCase<RemoveFromFavoritesUseCaseInput, void> {
  final Repository repository;

  RemoveFromFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(input) async {
    return repository.removeFromFavorites(
      userId: input.userId,
      homeId: input.homeId,
    );
  }
}

class RemoveFromFavoritesUseCaseInput {
  final String userId;
  final String homeId;

  RemoveFromFavoritesUseCaseInput({
    required this.userId,
    required this.homeId,
  });
}
