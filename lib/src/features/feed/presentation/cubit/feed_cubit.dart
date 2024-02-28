import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());
}
