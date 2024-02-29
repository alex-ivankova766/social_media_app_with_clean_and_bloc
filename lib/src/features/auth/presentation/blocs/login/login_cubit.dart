import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/auth/data/datasources/mock_auth_datasource.dart';

import '../../../../../shared/domain/entities/entities.dart';
import '../../../domain/entities/logged_in_user.dart';
import '../../../domain/usecases/usecases.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required LoginUser loginUser})
      : _loginUser = loginUser,
        super(LoginState.initial());

  final LoginUser _loginUser;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            username,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    debugPrint(password.value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            state.username,
            password,
          ],
        ),
      ),
    );
    debugPrint(state.status.isValidated.toString());
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginUser(LoginUserParams(
        username: state.username,
        password: state.password,
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LoginWithUsernameAndPasswordFailure catch (error) {
      emit(state.copyWith(
          errorText: error.message, status: FormzStatus.submissionFailure));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
