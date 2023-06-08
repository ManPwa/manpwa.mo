// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Follow> _$followSerializer = new _$FollowSerializer();

class _$FollowSerializer implements StructuredSerializer<Follow> {
  @override
  final Iterable<Type> types = const [Follow, _$Follow];
  @override
  final String wireName = 'Follow';

  @override
  Iterable<Object?> serialize(Serializers serializers, Follow object,
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
    value = object.is_following;
    if (value != null) {
      result
        ..add('is_following')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
  Follow deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FollowBuilder();

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
        case 'is_following':
          result.is_following = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
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

class _$Follow extends Follow {
  @override
  final String? id;
  @override
  final String? mangaId;
  @override
  final String? userId;
  @override
  final bool? is_following;
  @override
  final DateTime? deleted;
  @override
  final DateTime? updated;
  @override
  final String? updater;
  @override
  final DateTime? created;

  factory _$Follow([void Function(FollowBuilder)? updates]) =>
      (new FollowBuilder()..update(updates))._build();

  _$Follow._(
      {this.id,
      this.mangaId,
      this.userId,
      this.is_following,
      this.deleted,
      this.updated,
      this.updater,
      this.created})
      : super._();

  @override
  Follow rebuild(void Function(FollowBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FollowBuilder toBuilder() => new FollowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Follow &&
        id == other.id &&
        mangaId == other.mangaId &&
        userId == other.userId &&
        is_following == other.is_following &&
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
    _$hash = $jc(_$hash, is_following.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, updater.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Follow')
          ..add('id', id)
          ..add('mangaId', mangaId)
          ..add('userId', userId)
          ..add('is_following', is_following)
          ..add('deleted', deleted)
          ..add('updated', updated)
          ..add('updater', updater)
          ..add('created', created))
        .toString();
  }
}

class FollowBuilder implements Builder<Follow, FollowBuilder> {
  _$Follow? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _mangaId;
  String? get mangaId => _$this._mangaId;
  set mangaId(String? mangaId) => _$this._mangaId = mangaId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  bool? _is_following;
  bool? get is_following => _$this._is_following;
  set is_following(bool? is_following) => _$this._is_following = is_following;

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

  FollowBuilder();

  FollowBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _mangaId = $v.mangaId;
      _userId = $v.userId;
      _is_following = $v.is_following;
      _deleted = $v.deleted;
      _updated = $v.updated;
      _updater = $v.updater;
      _created = $v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Follow other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Follow;
  }

  @override
  void update(void Function(FollowBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Follow build() => _build();

  _$Follow _build() {
    final _$result = _$v ??
        new _$Follow._(
            id: id,
            mangaId: mangaId,
            userId: userId,
            is_following: is_following,
            deleted: deleted,
            updated: updated,
            updater: updater,
            created: created);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
