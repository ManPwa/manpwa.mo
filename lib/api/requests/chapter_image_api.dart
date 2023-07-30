import 'package:built_collection/built_collection.dart';

import '../../lib_wrappers/index.dart';
import '../entities/chapter_image.dart';
import '../entities/index.dart';

class ChapterImageApi {
  final NetworkAccess access;

  ChapterImageApi({required this.access});

  Future<BuiltList<ChapterImage>> getChapterImageList({required String chapterId}) async {
    final response = await access.fetch('api/chapter/$chapterId/image');
    return deserializeBuiltList<ChapterImage>(response.data);
  }

  Future readChapter({required String chapterId, required String token}) async {
    final response = await access.post('api/read-history/$chapterId',
        headers: {"Authorization": "Bearer $token"}, data: {});
    return response;
  }
}
