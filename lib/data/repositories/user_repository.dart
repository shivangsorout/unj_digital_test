import 'package:unj_digital_test/data/data_sources/api_service.dart';
import 'package:unj_digital_test/data/data_sources/local_storage.dart';
import 'package:unj_digital_test/data/models/user_model.dart';

class UserRepository {
  final ApiService apiService;
  final LocalStorage localStorage;

  UserRepository({required this.apiService, required this.localStorage});

  Future<List<UserModel>> fetchUsers(int page) async {
    List<UserModel> localUsers = await localStorage.getUsers(page);
    if (localUsers.isNotEmpty) {
      return localUsers;
    } else {
      try {
        List<UserModel> users = await apiService.fetchUsers(page);
        await localStorage.addUsersList(page, users);
        return users;
      } catch (e) {
        throw Exception('Failed to fetch users');
      }
    }
  }

  Future<UserModel> fetchUserById(int id) async {
    try {
      // Attempt to fetch user from local storage
      final localUser = await localStorage.getUserById(id);

      // If user exists in local storage and has a valid address, return it
      if (localUser.address.isNotEmpty) {
        return localUser;
      }

      // Fetch user from API if not found locally or address is empty
      final apiUser = await apiService.fetchUserById(id);

      // If ID is 1 or 2, store the API user as it is
      if (id == 1 || id == 2) {
        await localStorage.updateUser(id, apiUser);
        return apiUser;
      }

      // Otherwise, update the address to "Dummy Address" before storing
      final updatedUser = localUser.copyWith(address: "Dummy Address");
      await localStorage.updateUser(id, updatedUser);
      return updatedUser;
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await apiService.addUser(user);

      // Simulating local storage update since API is read-only
      final int newId = (await localStorage.getLatestIdAdded()) + 1;
      final int page = ((newId - 1) ~/ 10) + 1;

      // Fetch existing users for the page
      final List<UserModel> usersList = await localStorage.getUsers(page);

      // Add the new user at the end
      final updatedUsersList = [...usersList, user.copyWith(id: newId)];

      await localStorage.addUsersList(page, updatedUsersList);

      // Update the latest_user_id
      await localStorage.updateLatestId(newId);
    } catch (e) {
      throw Exception('Failed to add user');
    }
  }

  Future<void> updateUser(int id, UserModel user) async {
    try {
      await apiService.updateUser(user);

      // Simulating local update since API is read-only
      await localStorage.updateUser(id, user);
    } catch (e) {
      throw Exception('Failed to update user');
    }
  }
}
