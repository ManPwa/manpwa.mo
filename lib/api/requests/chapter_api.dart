import 'package:built_collection/built_collection.dart';

import '../../lib_wrappers/index.dart';
import '../entities/chapter.dart';
import '../entities/index.dart';

class ChapterApi {
  final NetworkAccess access;

  ChapterApi({required this.access});

  Future<BuiltList<Chapter>> getChapterList({required String mangaId}) async {
    final response = await access.fetch('api/manga/$mangaId/chapter');
    return deserializeBuiltList<Chapter>(response.data);
  }
}
