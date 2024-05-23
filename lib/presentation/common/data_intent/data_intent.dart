import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/domain.dart';
import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

  static UserRole? _userRole;

  static void setUserRole(UserRole role) => _userRole = role;

  static UserRole? getUserRole() {
    return _userRole;
  }

  static late UserModel _user;

  static void pushUser(UserModel user) {
    _user = user;
  }

  static UserModel getUser() {
    return _user;
  }

  static LatLng? _initialLocation;

  static void pushInitialLocation(LatLng initialLocation) {
    _initialLocation = initialLocation;
  }

  static LatLng? popInitialLocation() {
    LatLng? v = _initialLocation;
    _initialLocation = null;
    return v;
  }

//-----------------------------------
}
