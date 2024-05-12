import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/domain/entities/entities.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required SignupUser signupUser})
      : _signupUser = signupUser,
        super(SignupState.initial());

  final SignupUser _signupUser;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            username,
            state.email,
            state.password,
          ],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [
            state.username,
            email,
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
            state.email,
            password,
          ],
        ),
      ),
    );
    debugPrint(state.status.isValidated.toString());
  }

  Future<void> signupWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _signupUser(SignupUserParams(
          user: LoggedInUser(
        id: 'user_ 000',
        username: state.username,
        email: state.email,
        imagePath: 'assets/images/image_1.jpg',
      )));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
