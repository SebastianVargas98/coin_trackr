import 'package:coin_trackr/core/data/entities/user.dart';

abstract interface class UserLocalDataSource {
  User? getCurrentUser();
  void saveCurrentUser({required User user});
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  User? _user;

  @override
  User? getCurrentUser() {
    return _user;
  }

  @override
  void saveCurrentUser({required User user}) {
    _user = user;
  }
}
