import 'package:firebase_auth/firebase_auth.dart';

abstract class CacheDataSource {
  User? getSignedUser();
  Future<void> logout();
}

class CacheDataSourceImpl implements CacheDataSource {
  final FirebaseAuth? _firebaseAuth;

  CacheDataSourceImpl(this._firebaseAuth);

  @override
  User? getSignedUser() {
    return _firebaseAuth?.currentUser;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth?.signOut();
  }
}
