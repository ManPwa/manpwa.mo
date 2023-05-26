
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:manpwa/api/entities/manga.dart';

import 'serializers.dart';

part 'manga_response.g.dart';

abstract class MangaResponse implements Built<MangaResponse, MangaResponseBuilder> {
  int get total_manga;

  BuiltList<Manga> get manga_list;

  // use when transform field from snack_case to camelCase
  // @BuiltValueField(wireName: 'first_name')
  // String get firstName;

  MangaResponse._();
  factory MangaResponse([void Function(MangaResponseBuilder) updates]) = _$MangaResponse;

  static Serializer<MangaResponse> get serializer => _$mangaResponseSerializer;

  factory MangaResponse.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<MangaResponse>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
