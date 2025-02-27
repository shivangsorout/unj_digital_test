import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:unj_digital_test/data/models/user_model.dart';

class LocalStorage {
  static const String _usersKeyPrefix = 'cached_users_page_';
  static const String _latestUserIdKey = 'latest_user_id';

  Future<void> addUsersList(int page, List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString('$_usersKeyPrefix$page', usersJson);
  }

  Future<List<UserModel>> getUsers(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('$_usersKeyPrefix$page');
    if (usersJson != null) {
      List<dynamic> userList = jsonDecode(usersJson);
      return userList.map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<UserModel> getUserById(int id) async {
    final int page = ((id - 1) ~/ 10) + 1;
    final String key = '$_usersKeyPrefix$page';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(key);

    if (cachedData != null) {
      List<dynamic> users = jsonDecode(cachedData);
      for (var user in users) {
        if (user['id'] == id) {
          return UserModel.fromJson(user);
        }
      }
    }
    throw Exception('User not found in local storage');
  }

  Future<int> getLatestIdAdded() async {
    final prefs = await SharedPreferences.getInstance();

    // Try fetching the latest_user_id directly
    final latestId = prefs.getInt(_latestUserIdKey);
    if (latestId != null) {
      return latestId;
    }

    // Fetch all keys that start with "cached_users_page_"
    final allKeys =
        prefs
            .getKeys()
            .where((key) => key.startsWith("cached_users_page_"))
            .toList();
    if (allKeys.isEmpty) return 0; // No cached pages

    // Sort keys to get the largest page number first
    allKeys.sort((a, b) {
      final pageA = int.tryParse(a.split("_").last) ?? 0;
      final pageB = int.tryParse(b.split("_").last) ?? 0;
      return pageB.compareTo(pageA);
    });

    // Fetch user data from the largest pages until we find a non-empty list
    List<Map<String, dynamic>>? users;
    for (String key in allKeys) {
      final jsonString = prefs.getString(key);
      if (jsonString != null && jsonString.isNotEmpty) {
        users = (jsonDecode(jsonString) as List).cast<Map<String, dynamic>>();
        if (users.isNotEmpty) break;
      }
    }

    if (users == null || users.isEmpty) return 0; // No users found

    // Get the last user's id from the list
    final lastUserId = users.last[UserModel.keyId] ?? 0;

    // Store the latest user id in cache
    await updateLatestId(lastUserId);

    return lastUserId;
  }

  Future<int> getPagesLength() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys =
        prefs
            .getKeys()
            .where((key) => key.startsWith("cached_users_page_"))
            .toList();
    return allKeys.length;
  }

  Future<void> updateUser(int id, UserModel updatedUser) async {
    final int page = ((id - 1) ~/ 10) + 1;
    final String key = '$_usersKeyPrefix$page';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(key);

    if (cachedData != null) {
      List<dynamic> users = jsonDecode(cachedData);
      for (int i = 0; i < users.length; i++) {
        if (users[i]['id'] == id) {
          users[i] = updatedUser.toJson();
          break;
        }
      }
      await prefs.setString(key, jsonEncode(users));
    }
  }

  Future<void> updateLatestId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_latestUserIdKey, id);
  }

  Future<void> clearStorage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
