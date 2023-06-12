import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:manpwa/api/entities/user.dart';

import 'serializers.dart';

part 'comment.g.dart';

abstract class Comment implements Built<Comment, CommentBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  @BuiltValueField(wireName: 'manga_id')
  String? get mangaId;

  @BuiltValueField(wireName: 'user_id')
  String? get userId;

  String? get content;

  User? get user;

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

  Comment._();
  factory Comment([void Function(CommentBuilder) updates]) = _$Comment;

  static Serializer<Comment> get serializer => _$commentSerializer;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Comment>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
