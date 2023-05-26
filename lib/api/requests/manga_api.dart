import 'package:built_collection/built_collection.dart';

import '../../lib_wrappers/index.dart';
import '../entities/index.dart';
import '../entities/manga.dart';
import '../entities/manga_response.dart';

class MangaApi {
  final NetworkAccess access;

  MangaApi({required this.access});

  Future<MangaResponse> getMangaList() async {
    final response = await access.fetch('api/manga');
    return MangaResponse.fromJson(response.data);
  }

  Future<Manga> getMangaItem({
    required String mangaId,
  }) async {
    final response = await access.fetch('mangas/$mangaId');
    if (response.data == null) {
      throw Exception('manga not found.');
    }
    return Manga.fromJson(response.data);
  }
}
