import '../../../domain/models/domain.dart';
import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

  static UserType _selection = UserType.none;

  static void setSelection(UserType item) => _selection = item;

  static UserType getSelection() {
    return _selection;
  }
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

  static late User _user;

  static void pushUser(User role) => _user = role;

  static User getUser() {
    return _user;
  }



//-----------------------------------
}
