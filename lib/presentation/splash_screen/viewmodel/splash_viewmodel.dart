import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/sl.dart';
import '../../../domain/usecase/get_current_user_usecase.dart';
import '../../base/base_cubit.dart';
import '../../base/base_states.dart';
import '../states/splash_states.dart';

class SplashViewModel extends BaseCubit
    implements SplashViewModelInput, SplashViewModelOutput {
  static SplashViewModel get(context) => BlocProvider.of(context);

  final GetCurrentUserUseCase _getCurrentUserUseCase =
      sl<GetCurrentUserUseCase>();

  @override
  void start() {}

  Future<void> getCurrentUser() async {
    _getCurrentUserUseCase(null).then(
      (value) {
        value.fold(
          (l) {
            ErrorState(
              failure: l,
              retry: () {
                start();
              },
            );
          },
          (r) {
            //todo remove the line below
            emit(UserNotSignedState());
            //todo uncomment the 5 lines below
            //if (r == null) {
            //  emit(UserNotSignedState());
            //} else {
            //  emit(UserSignedState());
            //}
          },
        );
      },
    );
  }
}

abstract class SplashViewModelInput {}

abstract class SplashViewModelOutput {}
