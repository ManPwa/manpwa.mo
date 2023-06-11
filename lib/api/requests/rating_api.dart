import 'dart:developer';

import '../../lib_wrappers/index.dart';
import '../entities/rating.dart';
import '../entities/manga.dart';
import '../entities/manga_response.dart';

class RatingApi {
  final NetworkAccess access;

  RatingApi({required this.access});

  Future<Rating> getRatingItem(
      {required String mangaId, required String token}) async {
    final response = await access.fetch('api/manga/$mangaId/rating',
        headers: {"Authorization": "Bearer $token"});
    return Rating.fromJson(response.data);
  }

  Future ratingManga({required String mangaId, required String token,
      required int rating}) async {
    final response = await access.post('api/manga/$mangaId/rating',
        headers: {"Authorization": "Bearer $token"}, data: {"rating": rating});
    return response;
  }
}
