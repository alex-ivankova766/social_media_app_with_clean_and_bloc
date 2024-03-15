import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/entities.dart';
import '../../../../../shared/domain/usecases/usecases.dart';
import '../../../domain/usecases/get_users.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetUsers _getUsers;
  DiscoverBloc({required getUsers})
      : _getUsers = getUsers,
        super(DiscoverLoading()) {
    on<DiscoverGetUsers>(_onDiscoverGetUsers);
  }

  Future<void> _onDiscoverGetUsers(
    DiscoverGetUsers event,
    Emitter<DiscoverState> emit,
  ) async {
    debugPrint('Start getting users with: _onDiscoverGetUsers');
    List<User> users = await _getUsers(NoParams());
    emit(DiscoverLoaded(users: users));
  }
}
