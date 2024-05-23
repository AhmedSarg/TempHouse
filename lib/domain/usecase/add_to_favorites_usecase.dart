import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddToFavoritesUseCase
    extends BaseUseCase<AddToFavoritesUseCaseInput, void> {
  final Repository repository;

  AddToFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(input) async {
    return repository.addToFavorites(
      userId: input.userId,
      homeId: input.homeId,
    );
  }
}

class AddToFavoritesUseCaseInput {
  final String userId;
  final String homeId;

  AddToFavoritesUseCaseInput({
    required this.userId,
    required this.homeId,
  });
}
