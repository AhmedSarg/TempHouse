import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

  //------------------------------------
  //News Item
  // static NewsItemModel? _newsItemModel;
  //
  // static void pushNewsItem(NewsItemModel item) => _newsItemModel = item;
  //
  // static NewsItemModel? popNewsItem() {
  //   var r = _newsItemModel;
  //   _newsItemModel = null;
  //   return r;
  // }

  static UserRole? _userRole;

  static void pushUserRole(UserRole role) => _userRole = role;

  static UserRole? getUserRole() {
    return _userRole;
  }

//-----------------------------------
}
