import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'chapter.g.dart';

abstract class Chapter implements Built<Chapter, ChapterBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  @BuiltValueField(wireName: 'manga_id')
  String? get mangaId;

  double? get chapter;

  String? get title;

  String? get volumne;

  int? get pages;

  @BuiltValueField(wireName: '_deleted')
  DateTime? get deleted;

  @BuiltValueField(wireName: '_updated')
  DateTime? get updated;

  @BuiltValueField(wireName: '_updater')
  String? get updater;

  @BuiltValueField(wireName: '_created')
  DateTime? get created;

  // use when transform field from snack_case to camelCase
  // @BuiltValueField(wireName: 'first_name')
  // String get firstName;

  Chapter._();
  factory Chapter([void Function(ChapterBuilder) updates]) = _$Chapter;

  static Serializer<Chapter> get serializer => _$chapterSerializer;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Chapter>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
