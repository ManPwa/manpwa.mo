import 'dart:developer';

import 'package:built_collection/built_collection.dart';

import '../../lib_wrappers/index.dart';
import '../entities/index.dart';
import '../entities/manga.dart';
import '../entities/manga_response.dart';
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
}
