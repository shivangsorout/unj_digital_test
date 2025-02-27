class ApiConstants {
  static const String baseUrl =
      "https://c43d9c37-22a2-4d9b-9f13-923d980cd6ec.mock.pstmn.io";

  // Endpoints
  static String getUsers(int page) => "$baseUrl/users?page=$page";
  static String getUserById(int id) => "$baseUrl/users/$id";
  static const String addUser = "$baseUrl/users";
  static String editUser(int id) => "$baseUrl/users/$id";
}
