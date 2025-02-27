import 'package:equatable/equatable.dart';
import 'package:unj_digital_test/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UsersLoadingState extends UserState {}

class UsersLoadedState extends UserState {
  final List<UserModel> users;
  final bool hasMore;
  final int page;

  const UsersLoadedState({
    required this.users,
    required this.hasMore,
    required this.page,
  });

  @override
  List<Object?> get props => [users, hasMore, page];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserAddedState extends UserState {}

class UserUpdatedState extends UserState {}

class UserFetchedState extends UserState {
  final UserModel user;

  const UserFetchedState({required this.user});

  @override
  List<Object?> get props => [user];
}
