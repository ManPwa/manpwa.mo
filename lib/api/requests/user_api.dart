import '../../lib_wrappers/index.dart';
import '../entities/user.dart';

class UserApi {
  final NetworkAccess access;

  UserApi({required this.access});

  Future<User> getCurrentUser(
    { required String token }
  ) async {
    final response = await access.fetch('api/user/current', headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }
    return User.fromJson(response.data);
  }
  Future login(
    { required String email, required String password }
  ) async {
    final response = await access.post('api/user/login', data: {"email": email, "password": password});
    if (response.statusCode == 401) {
      throw Exception('Email or password is incorrect!');
    }
    return response;
  }

  Future register({
    required String username,
    required String email,
    required String password,
    required String date_of_birth,
    required bool gender
  }) async {
    var data = {
      "username": username,
      "email": email,
      "password": password,
      "date_of_birth": date_of_birth,
      "gender": gender
    };
    final response = await access.post('api/user/register', data: data);
    return response;
  }
}
