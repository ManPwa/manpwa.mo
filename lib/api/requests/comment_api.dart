import 'dart:developer';
import 'package:built_collection/built_collection.dart';
import '../../lib_wrappers/index.dart';
import '../entities/comment.dart';
import '../entities/manga.dart';
import '../entities/manga_response.dart';
import '../entities/index.dart';


class CommentApi {
  final NetworkAccess access;

  CommentApi({required this.access});

  Future<BuiltList<Comment>> getCommentList({required String mangaId}) async {
    final response = await access.fetch('api/manga/$mangaId/comment');
    return deserializeBuiltList<Comment>(response.data);
  }

  Future commentManga({required String mangaId, required String token,
      required int content}) async {
    final response = await access.post('api/manga/$mangaId/comment',
        headers: {"Authorization": "Bearer $token"}, data: {"content": content});
    return response;
  }
}
