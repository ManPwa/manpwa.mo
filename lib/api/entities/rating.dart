import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'rating.g.dart';

abstract class Rating implements Built<Rating, RatingBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  @BuiltValueField(wireName: 'manga_id')
  String? get mangaId;

  @BuiltValueField(wireName: 'user_id')
  String? get userId;

  double? get rating;

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

  Rating._();
  factory Rating([void Function(RatingBuilder) updates]) = _$Rating;

  static Serializer<Rating> get serializer => _$ratingSerializer;

  factory Rating.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Rating>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
