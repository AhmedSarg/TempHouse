import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/base/base_states.dart';

class HomeClickedState extends BaseStates {
  final HomeModel home;

  HomeClickedState(this.home);
}

class HomeReportState extends BaseStates {}
