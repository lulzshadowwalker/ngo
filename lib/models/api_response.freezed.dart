// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiMeta {

 int get total; int get perPage; int get currentPage; int get lastPage; int get from; int get to;
/// Create a copy of ApiMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiMetaCopyWith<ApiMeta> get copyWith => _$ApiMetaCopyWithImpl<ApiMeta>(this as ApiMeta, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiMeta&&(identical(other.total, total) || other.total == total)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,total,perPage,currentPage,lastPage,from,to);

@override
String toString() {
  return 'ApiMeta(total: $total, perPage: $perPage, currentPage: $currentPage, lastPage: $lastPage, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $ApiMetaCopyWith<$Res>  {
  factory $ApiMetaCopyWith(ApiMeta value, $Res Function(ApiMeta) _then) = _$ApiMetaCopyWithImpl;
@useResult
$Res call({
 int total, int perPage, int currentPage, int lastPage, int from, int to
});




}
/// @nodoc
class _$ApiMetaCopyWithImpl<$Res>
    implements $ApiMetaCopyWith<$Res> {
  _$ApiMetaCopyWithImpl(this._self, this._then);

  final ApiMeta _self;
  final $Res Function(ApiMeta) _then;

/// Create a copy of ApiMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? perPage = null,Object? currentPage = null,Object? lastPage = null,Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as int,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _ApiMeta implements ApiMeta {
  const _ApiMeta({required this.total, required this.perPage, required this.currentPage, required this.lastPage, required this.from, required this.to});
  

@override final  int total;
@override final  int perPage;
@override final  int currentPage;
@override final  int lastPage;
@override final  int from;
@override final  int to;

/// Create a copy of ApiMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiMetaCopyWith<_ApiMeta> get copyWith => __$ApiMetaCopyWithImpl<_ApiMeta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiMeta&&(identical(other.total, total) || other.total == total)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,total,perPage,currentPage,lastPage,from,to);

@override
String toString() {
  return 'ApiMeta(total: $total, perPage: $perPage, currentPage: $currentPage, lastPage: $lastPage, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$ApiMetaCopyWith<$Res> implements $ApiMetaCopyWith<$Res> {
  factory _$ApiMetaCopyWith(_ApiMeta value, $Res Function(_ApiMeta) _then) = __$ApiMetaCopyWithImpl;
@override @useResult
$Res call({
 int total, int perPage, int currentPage, int lastPage, int from, int to
});




}
/// @nodoc
class __$ApiMetaCopyWithImpl<$Res>
    implements _$ApiMetaCopyWith<$Res> {
  __$ApiMetaCopyWithImpl(this._self, this._then);

  final _ApiMeta _self;
  final $Res Function(_ApiMeta) _then;

/// Create a copy of ApiMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? perPage = null,Object? currentPage = null,Object? lastPage = null,Object? from = null,Object? to = null,}) {
  return _then(_ApiMeta(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as int,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ApiLinks {

 String? get first; String? get last; String? get prev; String? get next;
/// Create a copy of ApiLinks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiLinksCopyWith<ApiLinks> get copyWith => _$ApiLinksCopyWithImpl<ApiLinks>(this as ApiLinks, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiLinks&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last)&&(identical(other.prev, prev) || other.prev == prev)&&(identical(other.next, next) || other.next == next));
}


@override
int get hashCode => Object.hash(runtimeType,first,last,prev,next);

@override
String toString() {
  return 'ApiLinks(first: $first, last: $last, prev: $prev, next: $next)';
}


}

/// @nodoc
abstract mixin class $ApiLinksCopyWith<$Res>  {
  factory $ApiLinksCopyWith(ApiLinks value, $Res Function(ApiLinks) _then) = _$ApiLinksCopyWithImpl;
@useResult
$Res call({
 String? first, String? last, String? prev, String? next
});




}
/// @nodoc
class _$ApiLinksCopyWithImpl<$Res>
    implements $ApiLinksCopyWith<$Res> {
  _$ApiLinksCopyWithImpl(this._self, this._then);

  final ApiLinks _self;
  final $Res Function(ApiLinks) _then;

/// Create a copy of ApiLinks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? first = freezed,Object? last = freezed,Object? prev = freezed,Object? next = freezed,}) {
  return _then(_self.copyWith(
first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as String?,prev: freezed == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as String?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _ApiLinks implements ApiLinks {
  const _ApiLinks({this.first, this.last, this.prev, this.next});
  

@override final  String? first;
@override final  String? last;
@override final  String? prev;
@override final  String? next;

/// Create a copy of ApiLinks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiLinksCopyWith<_ApiLinks> get copyWith => __$ApiLinksCopyWithImpl<_ApiLinks>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiLinks&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last)&&(identical(other.prev, prev) || other.prev == prev)&&(identical(other.next, next) || other.next == next));
}


@override
int get hashCode => Object.hash(runtimeType,first,last,prev,next);

@override
String toString() {
  return 'ApiLinks(first: $first, last: $last, prev: $prev, next: $next)';
}


}

/// @nodoc
abstract mixin class _$ApiLinksCopyWith<$Res> implements $ApiLinksCopyWith<$Res> {
  factory _$ApiLinksCopyWith(_ApiLinks value, $Res Function(_ApiLinks) _then) = __$ApiLinksCopyWithImpl;
@override @useResult
$Res call({
 String? first, String? last, String? prev, String? next
});




}
/// @nodoc
class __$ApiLinksCopyWithImpl<$Res>
    implements _$ApiLinksCopyWith<$Res> {
  __$ApiLinksCopyWithImpl(this._self, this._then);

  final _ApiLinks _self;
  final $Res Function(_ApiLinks) _then;

/// Create a copy of ApiLinks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? first = freezed,Object? last = freezed,Object? prev = freezed,Object? next = freezed,}) {
  return _then(_ApiLinks(
first: freezed == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as String?,last: freezed == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as String?,prev: freezed == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as String?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PaginatedResponse<T> {

 List<T> get data; ApiMeta get meta; ApiLinks get links;
/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedResponseCopyWith<T, PaginatedResponse<T>> get copyWith => _$PaginatedResponseCopyWithImpl<T, PaginatedResponse<T>>(this as PaginatedResponse<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedResponse<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.links, links) || other.links == links));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),meta,links);

@override
String toString() {
  return 'PaginatedResponse<$T>(data: $data, meta: $meta, links: $links)';
}


}

/// @nodoc
abstract mixin class $PaginatedResponseCopyWith<T,$Res>  {
  factory $PaginatedResponseCopyWith(PaginatedResponse<T> value, $Res Function(PaginatedResponse<T>) _then) = _$PaginatedResponseCopyWithImpl;
@useResult
$Res call({
 List<T> data, ApiMeta meta, ApiLinks links
});


$ApiMetaCopyWith<$Res> get meta;$ApiLinksCopyWith<$Res> get links;

}
/// @nodoc
class _$PaginatedResponseCopyWithImpl<T,$Res>
    implements $PaginatedResponseCopyWith<T, $Res> {
  _$PaginatedResponseCopyWithImpl(this._self, this._then);

  final PaginatedResponse<T> _self;
  final $Res Function(PaginatedResponse<T>) _then;

/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,Object? links = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<T>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMeta,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as ApiLinks,
  ));
}
/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaCopyWith<$Res> get meta {
  
  return $ApiMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiLinksCopyWith<$Res> get links {
  
  return $ApiLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}


/// @nodoc


class _PaginatedResponse<T> implements PaginatedResponse<T> {
  const _PaginatedResponse({required final  List<T> data, required this.meta, required this.links}): _data = data;
  

 final  List<T> _data;
@override List<T> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  ApiMeta meta;
@override final  ApiLinks links;

/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedResponseCopyWith<T, _PaginatedResponse<T>> get copyWith => __$PaginatedResponseCopyWithImpl<T, _PaginatedResponse<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedResponse<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.links, links) || other.links == links));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),meta,links);

@override
String toString() {
  return 'PaginatedResponse<$T>(data: $data, meta: $meta, links: $links)';
}


}

/// @nodoc
abstract mixin class _$PaginatedResponseCopyWith<T,$Res> implements $PaginatedResponseCopyWith<T, $Res> {
  factory _$PaginatedResponseCopyWith(_PaginatedResponse<T> value, $Res Function(_PaginatedResponse<T>) _then) = __$PaginatedResponseCopyWithImpl;
@override @useResult
$Res call({
 List<T> data, ApiMeta meta, ApiLinks links
});


@override $ApiMetaCopyWith<$Res> get meta;@override $ApiLinksCopyWith<$Res> get links;

}
/// @nodoc
class __$PaginatedResponseCopyWithImpl<T,$Res>
    implements _$PaginatedResponseCopyWith<T, $Res> {
  __$PaginatedResponseCopyWithImpl(this._self, this._then);

  final _PaginatedResponse<T> _self;
  final $Res Function(_PaginatedResponse<T>) _then;

/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,Object? links = null,}) {
  return _then(_PaginatedResponse<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<T>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMeta,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as ApiLinks,
  ));
}

/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaCopyWith<$Res> get meta {
  
  return $ApiMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of PaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiLinksCopyWith<$Res> get links {
  
  return $ApiLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}

// dart format on
