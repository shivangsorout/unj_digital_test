import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unj_digital_test/core/constants/api_constants.dart';
import 'package:unj_digital_test/data/models/user_model.dart';

class ApiService {
  Future<List<UserModel>> fetchUsers(int page) async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.getUsers(page)));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> usersData = data['users'];
        return usersData.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<UserModel> fetchUserById(int id) async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.getUserById(id)));
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.addUser),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add user');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final response = await http.put(
        Uri.parse(ApiConstants.editUser(user.id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
