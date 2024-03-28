import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> {
  // TODO: Add a use case to create a new post and save it.
  
  AddContentCubit() : super(AddContentState.initial());

  void videoChanged(File file) {
    emit(state.copyWith(video: file, status: AddContentStatus.loading,));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(caption: caption, status: AddContentStatus.loading,));
  }

  void submit() {

  }

  void reser() {
    emit(AddContentState.initial());
  }

}
