import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(ContentInitial()) {
    on<ContentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
