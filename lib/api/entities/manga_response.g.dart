// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MangaResponse> _$mangaResponseSerializer =
    new _$MangaResponseSerializer();

class _$MangaResponseSerializer implements StructuredSerializer<MangaResponse> {
  @override
  final Iterable<Type> types = const [MangaResponse, _$MangaResponse];
  @override
  final String wireName = 'MangaResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, MangaResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'total_manga',
      serializers.serialize(object.total_manga,
          specifiedType: const FullType(int)),
      'manga_list',
      serializers.serialize(object.manga_list,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Manga)])),
    ];

    return result;
  }

  @override
  MangaResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MangaResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'total_manga':
          result.total_manga = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'manga_list':
          result.manga_list.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Manga)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$MangaResponse extends MangaResponse {
  @override
  final int total_manga;
  @override
  final BuiltList<Manga> manga_list;

  factory _$MangaResponse([void Function(MangaResponseBuilder)? updates]) =>
      (new MangaResponseBuilder()..update(updates))._build();

  _$MangaResponse._({required this.total_manga, required this.manga_list})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        total_manga, r'MangaResponse', 'total_manga');
    BuiltValueNullFieldError.checkNotNull(
        manga_list, r'MangaResponse', 'manga_list');
  }

  @override
  MangaResponse rebuild(void Function(MangaResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MangaResponseBuilder toBuilder() => new MangaResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MangaResponse &&
        total_manga == other.total_manga &&
        manga_list == other.manga_list;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total_manga.hashCode);
    _$hash = $jc(_$hash, manga_list.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MangaResponse')
          ..add('total_manga', total_manga)
          ..add('manga_list', manga_list))
        .toString();
  }
}

class MangaResponseBuilder
    implements Builder<MangaResponse, MangaResponseBuilder> {
  _$MangaResponse? _$v;

  int? _total_manga;
  int? get total_manga => _$this._total_manga;
  set total_manga(int? total_manga) => _$this._total_manga = total_manga;

  ListBuilder<Manga>? _manga_list;
  ListBuilder<Manga> get manga_list =>
      _$this._manga_list ??= new ListBuilder<Manga>();
  set manga_list(ListBuilder<Manga>? manga_list) =>
      _$this._manga_list = manga_list;

  MangaResponseBuilder();

  MangaResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total_manga = $v.total_manga;
      _manga_list = $v.manga_list.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MangaResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MangaResponse;
  }

  @override
  void update(void Function(MangaResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MangaResponse build() => _build();

  _$MangaResponse _build() {
    _$MangaResponse _$result;
    try {
      _$result = _$v ??
          new _$MangaResponse._(
              total_manga: BuiltValueNullFieldError.checkNotNull(
                  total_manga, r'MangaResponse', 'total_manga'),
              manga_list: manga_list.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'manga_list';
        manga_list.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MangaResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
