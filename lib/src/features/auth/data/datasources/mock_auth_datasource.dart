import 'dart:async';

import '../../../../shared/domain/entities/entities.dart';
import '../../domain/entities/entities.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class MockAuthDatasource {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<void> signup({required LoggedInUser loggedInUser});
  Future<void> login({
    required Username username,
    required Password password,
  });
  Future<void> logout();
}

class MockAuthDatasourceImpl extends MockAuthDatasource {
  MockAuthDatasourceImpl({CacheClient? cache})
      : _cache = cache ?? CacheClient();
  final CacheClient _cache;
  final _authStatusStreamController = StreamController<AuthStatus>();

  static const userCacheKey = '__user_cache_key';
  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _authStatusStreamController.stream;
  }

  @override
  Future<LoggedInUser> get loggedInUser {
    return Future.delayed(const Duration(milliseconds: 300), () {
      return _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    });
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _allUsers.add(loggedInUser);

      _updateLoggedInUser(
        id: loggedInUser.id,
        username: loggedInUser.username,
        email: loggedInUser.email,
      );

      _authStatusStreamController.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Future<void> login({
    required Username username,
    required Password password,
  }) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      for (final user in _allUsers) {
        if (user.username.value == username.value) {
          _updateLoggedInUser(
            id: user.id,
            username: user.username,
          );
          _authStatusStreamController.add(AuthStatus.authenticated);
          return;
        }
      }
      throw LoginWithUsernameAndPasswordFailure.fromCode(
        'user-not-found',
      );
    });
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _cache.write(
        key: userCacheKey,
        value: LoggedInUser.empty,
      );
      _authStatusStreamController.add(AuthStatus.unauthenticated);
    });
  }

  void _updateLoggedInUser({
    String? id,
    Username? username,
    Email? email,
  }) {
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    _cache.write(
        key: userCacheKey,
        value: loggedInUser.copyWith(
          id: id,
          username: username,
          email: email,
        ));
  }

  final List<User> _allUsers = <User>[
    const User(
      id: 'user_1',
      username: Username.dirty('Massimo'),
      imagePath: 'assets/images/image_1.jpg',
    ),
    const User(
      id: 'user_2',
      username: Username.dirty('Sarah'),
      imagePath: 'assets/images/image_2.jpg',
    ),
    const User(
      id: 'user_3',
      username: Username.dirty('John'),
      imagePath: 'assets/images/image_3.jpg',
    ),
  ];
}

class CacheClient {
  CacheClient() : _cache = <String, Object>{};
  final Map<String, Object> _cache;

  void write<T extends Object>({
    required String key,
    required T value,
  }) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

class LoginWithUsernameAndPasswordFailure implements Exception {
  const LoginWithUsernameAndPasswordFailure(this.message);

  final String message;

  factory LoginWithUsernameAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-username':
        return const LoginWithUsernameAndPasswordFailure(
            'Username is not valid.');
      case 'user-not-found':
        return const LoginWithUsernameAndPasswordFailure(
            'Username is not found, please create an account.');
      default:
        return const LoginWithUsernameAndPasswordFailure(
            'An unknown exception occured.');
    }
  }
}
