import 'package:equatable/equatable.dart';
import 'package:unj_digital_test/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsersEvent extends UserEvent {
  final int page;

  FetchUsersEvent({required this.page});

  @override
  List<Object?> get props => [page];
}

class FetchUserByIdEvent extends UserEvent {
  final int id;

  FetchUserByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddUserEvent extends UserEvent {
  final UserModel user;

  AddUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUserEvent extends UserEvent {
  final int id;
  final UserModel user;

  UpdateUserEvent({required this.id, required this.user});

  @override
  List<Object?> get props => [id, user];
}
