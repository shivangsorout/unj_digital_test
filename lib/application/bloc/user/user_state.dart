import 'package:equatable/equatable.dart';
import 'package:unj_digital_test/data/models/user_model.dart';

abstract class UserState extends Equatable {
  final List<UserModel> users;
  const UserState({required this.users});

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {
  const UserInitialState({super.users = const []});
}

class UsersLoadingState extends UserState {
  const UsersLoadingState({required super.users});
}

class UsersLoadedState extends UserState {
  final bool hasMore;
  final int page;

  const UsersLoadedState({
    required super.users,
    required this.hasMore,
    required this.page,
  });

  @override
  List<Object?> get props => [users, hasMore, page];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message, required super.users});

  @override
  List<Object?> get props => [message];
}

class UserAddedState extends UserState {
  const UserAddedState({required super.users});
}

class UserUpdatedState extends UserState {
  const UserUpdatedState({required super.users});
}

class UserFetchedState extends UserState {
  final UserModel user;

  const UserFetchedState({required this.user, required super.users});

  @override
  List<Object?> get props => [user];
}
