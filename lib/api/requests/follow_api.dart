import 'dart:developer';

import '../../lib_wrappers/index.dart';
import '../entities/follow.dart';
import '../entities/manga.dart';
import '../entities/manga_response.dart';

class FollowApi {
  final NetworkAccess access;

  FollowApi({required this.access});

  Future<Follow> getFollowItem(
    { required String mangaId, required String token }
  ) async {
    final response = await access.fetch('api/manga/$mangaId/follow',
        headers: {"Authorization": "Bearer $token"});
    return Follow.fromJson(response.data);
  }

  Future followManga({ required String mangaId, required String token }) async {
    final response = await access.post('api/manga/$mangaId/follow',
        headers: {"Authorization": "Bearer $token"},
        data: {});
    return response;
  }
}
