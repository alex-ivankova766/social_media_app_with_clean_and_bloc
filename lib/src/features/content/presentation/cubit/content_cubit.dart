import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentInitial());
}
