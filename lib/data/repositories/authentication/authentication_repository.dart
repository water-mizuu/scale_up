import 'dart:async';

import 'package:scale_up/data/models/user.dart';

abstract class AuthenticationRepository {
  Future<User?> logIn({required String username, required String password});
  Future<void> logOut();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<User?> logIn({required String username, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return User.empty;
  }

  @override
  Future<void> logOut() async {}
}
