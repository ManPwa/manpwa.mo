// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_image.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChapterImage> _$chapterImageSerializer =
    new _$ChapterImageSerializer();

class _$ChapterImageSerializer implements StructuredSerializer<ChapterImage> {
  @override
  final Iterable<Type> types = const [ChapterImage, _$ChapterImage];
  @override
  final String wireName = 'ChapterImage';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChapterImage object,
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
    value = object.chapterId;
    if (value != null) {
      result
        ..add('chapter_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.page;
    if (value != null) {
      result
        ..add('page')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.image_url;
    if (value != null) {
      result
        ..add('image_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  ChapterImage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChapterImageBuilder();

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
        case 'chapter_id':
          result.chapterId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'page':
          result.page = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'image_url':
          result.image_url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$ChapterImage extends ChapterImage {
  @override
  final String? id;
  @override
  final String? chapterId;
  @override
  final int? page;
  @override
  final String? image_url;
  @override
  final DateTime? deleted;
  @override
  final DateTime? updated;
  @override
  final String? updater;
  @override
  final DateTime? created;

  factory _$ChapterImage([void Function(ChapterImageBuilder)? updates]) =>
      (new ChapterImageBuilder()..update(updates))._build();

  _$ChapterImage._(
      {this.id,
      this.chapterId,
      this.page,
      this.image_url,
      this.deleted,
      this.updated,
      this.updater,
      this.created})
      : super._();

  @override
  ChapterImage rebuild(void Function(ChapterImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterImageBuilder toBuilder() => new ChapterImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterImage &&
        id == other.id &&
        chapterId == other.chapterId &&
        page == other.page &&
        image_url == other.image_url &&
        deleted == other.deleted &&
        updated == other.updated &&
        updater == other.updater &&
        created == other.created;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, image_url.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, updater.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChapterImage')
          ..add('id', id)
          ..add('chapterId', chapterId)
          ..add('page', page)
          ..add('image_url', image_url)
          ..add('deleted', deleted)
          ..add('updated', updated)
          ..add('updater', updater)
          ..add('created', created))
        .toString();
  }
}

class ChapterImageBuilder
    implements Builder<ChapterImage, ChapterImageBuilder> {
  _$ChapterImage? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _chapterId;
  String? get chapterId => _$this._chapterId;
  set chapterId(String? chapterId) => _$this._chapterId = chapterId;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  String? _image_url;
  String? get image_url => _$this._image_url;
  set image_url(String? image_url) => _$this._image_url = image_url;

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

  ChapterImageBuilder();

  ChapterImageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _chapterId = $v.chapterId;
      _page = $v.page;
      _image_url = $v.image_url;
      _deleted = $v.deleted;
      _updated = $v.updated;
      _updater = $v.updater;
      _created = $v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterImage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChapterImage;
  }

  @override
  void update(void Function(ChapterImageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterImage build() => _build();

  _$ChapterImage _build() {
    final _$result = _$v ??
        new _$ChapterImage._(
            id: id,
            chapterId: chapterId,
            page: page,
            image_url: image_url,
            deleted: deleted,
            updated: updated,
            updater: updater,
            created: created);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
