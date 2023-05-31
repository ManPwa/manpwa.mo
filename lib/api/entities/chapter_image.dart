import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'chapter_image.g.dart';

abstract class ChapterImage implements Built<ChapterImage, ChapterImageBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  @BuiltValueField(wireName: 'chapter_id')
  String? get chapterId;

  int? get page;

  String? get image_url;

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

  ChapterImage._();
  factory ChapterImage([void Function(ChapterImageBuilder) updates]) = _$ChapterImage;

  static Serializer<ChapterImage> get serializer => _$chapterImageSerializer;

  factory ChapterImage.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<ChapterImage>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
