import 'package:built_collection/built_collection.dart';
import 'package:dio/src/response.dart';

import '../../lib_wrappers/index.dart';
import '../entities/chapter.dart';
import '../entities/index.dart';

class ChapterApi {
  final NetworkAccess access;

  ChapterApi({required this.access});

  Future<BuiltList<Chapter>> getChapterList({required String mangaId, String token = ""}) async {
    Response response;
    if (token == "") {
      response = await access.fetch('api/manga/$mangaId/chapter');
    } else {
      response = await access.fetch('api/manga/$mangaId/chapter',
          headers: {"Authorization": "Bearer $token"});
    }
    
    return deserializeBuiltList<Chapter>(response.data);
  }

}
