// import 'package:equatable/equatable.dart';
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// event (input)
class GetUserList extends UserEvent {}
