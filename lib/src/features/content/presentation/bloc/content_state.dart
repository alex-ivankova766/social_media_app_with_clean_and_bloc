part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();  

  @override
  List<Object> get props => [];
}
class ContentInitial extends ContentState {}
