import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'follow.g.dart';

abstract class Follow implements Built<Follow, FollowBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  @BuiltValueField(wireName: 'manga_id')
  String? get mangaId;

  @BuiltValueField(wireName: 'user_id')
  String? get userId;

  bool? get is_following;

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

  Follow._();
  factory Follow([void Function(FollowBuilder) updates]) = _$Follow;

  static Serializer<Follow> get serializer => _$followSerializer;

  factory Follow.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Follow>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
