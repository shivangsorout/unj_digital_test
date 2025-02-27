import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unj_digital_test/data/models/user_model.dart';
import 'package:unj_digital_test/data/repositories/user_repository.dart';
import 'package:unj_digital_test/application/bloc/user/user_event.dart';
import 'package:unj_digital_test/application/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<FetchUserByIdEvent>(_onFetchUserById);
    on<AddUserEvent>(_onAddUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UsersLoadingState(users: event.page == 1 ? [] : state.users));
    try {
      final newPageUsers = await userRepository.fetchUsers(event.page);
      final List<UserModel> users = [
        ...(event.page == 1 ? [] : state.users),
        ...newPageUsers,
      ];

      // Assuming each page should return 10 users
      const int pageSize = 10;
      final bool hasMore = users.length == (pageSize * event.page);

      emit(UsersLoadedState(users: users, hasMore: hasMore, page: event.page));
    } catch (e) {
      emit(
        UserErrorState(
          message: 'Failed to fetch users: ${e.toString()}',
          users: state.users,
        ),
      );
    }
  }

  Future<void> _onFetchUserById(
    FetchUserByIdEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UsersLoadingState(users: state.users));
    try {
      final user = await userRepository.fetchUserById(event.id);
      emit(UserFetchedState(user: user, users: state.users));
    } catch (e) {
      emit(
        UserErrorState(
          message: 'Failed to fetch user: ${e.toString()}',
          users: state.users,
        ),
      );
    }
  }

  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    try {
      await userRepository.addUser(event.user);
      emit(UserAddedState(users: state.users));
      add(FetchUsersEvent(page: 1)); // Refresh the user list
    } catch (e) {
      emit(
        UserErrorState(
          message: 'Failed to add user: ${e.toString()}',
          users: state.users,
        ),
      );
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UsersLoadingState(users: state.users));
      await userRepository.updateUser(event.id, event.user);
      emit(UserUpdatedState(users: state.users));
      add(FetchUserByIdEvent(event.id));
    } catch (e) {
      emit(
        UserErrorState(
          message: 'Failed to update user: ${e.toString()}',
          users: state.users,
        ),
      );
    }
  }
}
