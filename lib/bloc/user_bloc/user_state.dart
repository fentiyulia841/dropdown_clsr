// import 'package:area_api/models/wilayah_model.dart';
// import 'package:equatable/equatable.dart';

part of 'user_bloc.dart';


abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}
// response
class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel userModel;
  const UserLoaded(this.userModel);
}

class UserError extends UserState {
  final String? message;
  const UserError(this.message);
}
