// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Rating> _$ratingSerializer = new _$RatingSerializer();

class _$RatingSerializer implements StructuredSerializer<Rating> {
  @override
  final Iterable<Type> types = const [Rating, _$Rating];
  @override
  final String wireName = 'Rating';

  @override
  Iterable<Object?> serialize(Serializers serializers, Rating object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mangaId;
    if (value != null) {
      result
        ..add('manga_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.deleted;
    if (value != null) {
      result
        ..add('_deleted')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updated;
    if (value != null) {
      result
        ..add('_updated')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updater;
    if (value != null) {
      result
        ..add('_updater')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.created;
    if (value != null) {
      result
        ..add('_created')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  Rating deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RatingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '_id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'manga_id':
          result.mangaId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case '_deleted':
          result.deleted = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case '_updated':
          result.updated = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case '_updater':
          result.updater = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case '_created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$Rating extends Rating {
  @override
  final String? id;
  @override
  final String? mangaId;
  @override
  final String? userId;
  @override
  final double? rating;
  @override
  final DateTime? deleted;
  @override
  final DateTime? updated;
  @override
  final String? updater;
  @override
  final DateTime? created;

  factory _$Rating([void Function(RatingBuilder)? updates]) =>
      (new RatingBuilder()..update(updates))._build();

  _$Rating._(
      {this.id,
      this.mangaId,
      this.userId,
      this.rating,
      this.deleted,
      this.updated,
      this.updater,
      this.created})
      : super._();

  @override
  Rating rebuild(void Function(RatingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RatingBuilder toBuilder() => new RatingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Rating &&
        id == other.id &&
        mangaId == other.mangaId &&
        userId == other.userId &&
        rating == other.rating &&
        deleted == other.deleted &&
        updated == other.updated &&
        updater == other.updater &&
        created == other.created;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, mangaId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, updater.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Rating')
          ..add('id', id)
          ..add('mangaId', mangaId)
          ..add('userId', userId)
          ..add('rating', rating)
          ..add('deleted', deleted)
          ..add('updated', updated)
          ..add('updater', updater)
          ..add('created', created))
        .toString();
  }
}

class RatingBuilder implements Builder<Rating, RatingBuilder> {
  _$Rating? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _mangaId;
  String? get mangaId => _$this._mangaId;
  set mangaId(String? mangaId) => _$this._mangaId = mangaId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  DateTime? _deleted;
  DateTime? get deleted => _$this._deleted;
  set deleted(DateTime? deleted) => _$this._deleted = deleted;

  DateTime? _updated;
  DateTime? get updated => _$this._updated;
  set updated(DateTime? updated) => _$this._updated = updated;

  String? _updater;
  String? get updater => _$this._updater;
  set updater(String? updater) => _$this._updater = updater;

  DateTime? _created;
  DateTime? get created => _$this._created;
  set created(DateTime? created) => _$this._created = created;

  RatingBuilder();

  RatingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _mangaId = $v.mangaId;
      _userId = $v.userId;
      _rating = $v.rating;
      _deleted = $v.deleted;
      _updated = $v.updated;
      _updater = $v.updater;
      _created = $v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Rating other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Rating;
  }

  @override
  void update(void Function(RatingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Rating build() => _build();

  _$Rating _build() {
    final _$result = _$v ??
        new _$Rating._(
            id: id,
            mangaId: mangaId,
            userId: userId,
            rating: rating,
            deleted: deleted,
            updated: updated,
            updater: updater,
            created: created);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
