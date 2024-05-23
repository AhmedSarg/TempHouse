import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/domain/models/enums.dart';
import 'package:temp_house/domain/usecase/get_all_favorites_usecase.dart';
import 'package:temp_house/domain/usecase/remove_from_favorites_usecase.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../../app/sl.dart';
import '../../../domain/models/domain.dart';
import '../../../domain/usecase/add_to_favorites_usecase.dart';
import 'states/main_layout_states.dart';

class MainLayoutViewModel extends BaseCubit
    implements MainLayoutViewModelInput, MainLayoutViewModelOutput {
  static MainLayoutViewModel get(context) => BlocProvider.of(context);

  final AddToFavoritesUseCase _addToFavoritesUseCase =
      sl<AddToFavoritesUseCase>();

  final RemoveFromFavoritesUseCase _removeFromFavoritesUseCase =
      sl<RemoveFromFavoritesUseCase>();

  final GetAllFavoritesUseCase _getAllFavoritesUseCase =
      sl<GetAllFavoritesUseCase>();

  final _userRole = DataIntent.getUserRole();

  final _user = DataIntent.getUser();

  late final Stream<List<Future<HomeModel>>> _favouriteHomesStream;

  Future<void> addToFavorites(String homeId) async {
    DataIntent.getUser().addHomeToFavorites(homeId);
    emit(MainLayoutHomeAddedToFavoritesState());
    _addToFavoritesUseCase(
      AddToFavoritesUseCaseInput(
        userId: DataIntent.getUser().uid,
        homeId: homeId,
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
          (r) {},
        );
      },
    );
  }

  Future<void> removeFromFavorites(String homeId) async {
    DataIntent.getUser().removeHomeFromFavorites(homeId);
    emit(MainLayoutHomeRemovedFromFavoritesState());
    _removeFromFavoritesUseCase(
      RemoveFromFavoritesUseCaseInput(
        userId: DataIntent.getUser().uid,
        homeId: homeId,
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
          (r) {},
        );
      },
    );
  }

  Future<void> getAllFavorites() async {
    _getAllFavoritesUseCase(
      GetAllFavoritesUseCaseInput(
        userId: DataIntent.getUser().uid,
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
            _favouriteHomesStream = r;
            emit(ContentState());
          },
        );
      },
    );
  }

  bool isHomeFavorite(String homeId) {
    return _user.isHomeInFavorites(homeId);
  }

  @override
  void start() {
    emit(LoadingState());
    getAllFavorites();
  }

  @override
  UserRole get getUserRole => _userRole!;

  @override
  UserModel get getUser => _user;

  @override
  Stream<List<Future<HomeModel>>> get getFavouriteHomesStream =>
      _favouriteHomesStream;
}

abstract class MainLayoutViewModelInput {}

abstract class MainLayoutViewModelOutput {
  UserRole get getUserRole;

  UserModel get getUser;

  Stream<List<Future<HomeModel>>> get getFavouriteHomesStream;
}
