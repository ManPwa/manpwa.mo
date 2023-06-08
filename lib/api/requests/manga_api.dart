import 'dart:developer';

import '../../lib_wrappers/index.dart';
import '../entities/manga.dart';
import '../entities/manga_response.dart';

class MangaApi {
  final NetworkAccess access;

  MangaApi({required this.access});

  Future<MangaResponse> getMangaList(
      Map<String, dynamic> params) async {
    final response = await access.fetch('api/manga', queryParameters: params);
    return MangaResponse.fromJson(response.data);
  }

  Future<MangaResponse> getFollowingMangaList({ required String token }) async {
    final response = await access.fetch('api/following-manga', headers: {"Authorization": "Bearer $token"});
    return MangaResponse.fromJson(response.data);
  }

  Future<Manga> getMangaItem(
    String mangaId,
  ) async {
    final response = await access.fetch('api/manga/$mangaId');
    if (response.data == null) {
      throw Exception('manga not found.');
    }
    return Manga.fromJson(response.data);
  }
}
