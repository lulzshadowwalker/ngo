// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opportunities_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OpportunitiesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpportunitiesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OpportunitiesState()';
}


}

/// @nodoc
class $OpportunitiesStateCopyWith<$Res>  {
$OpportunitiesStateCopyWith(OpportunitiesState _, $Res Function(OpportunitiesState) __);
}


/// @nodoc


class _Initial implements OpportunitiesState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OpportunitiesState.initial()';
}


}




/// @nodoc


class _Loading implements OpportunitiesState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OpportunitiesState.loading()';
}


}




/// @nodoc


class _Loaded implements OpportunitiesState {
  const _Loaded({required final  List<Opportunity> opportunities, required this.meta, required this.links, this.currentPage = 1, this.searchQuery = '', final  List<String> selectedTags = const [], this.selectedSectorId, this.selectedLocationId, this.isFeatured = false}): _opportunities = opportunities,_selectedTags = selectedTags;
  

 final  List<Opportunity> _opportunities;
 List<Opportunity> get opportunities {
  if (_opportunities is EqualUnmodifiableListView) return _opportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opportunities);
}

 final  ApiMeta meta;
 final  ApiLinks links;
@JsonKey() final  int currentPage;
@JsonKey() final  String searchQuery;
 final  List<String> _selectedTags;
@JsonKey() List<String> get selectedTags {
  if (_selectedTags is EqualUnmodifiableListView) return _selectedTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTags);
}

 final  int? selectedSectorId;
 final  int? selectedLocationId;
@JsonKey() final  bool isFeatured;

/// Create a copy of OpportunitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._opportunities, _opportunities)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.links, links) || other.links == links)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other._selectedTags, _selectedTags)&&(identical(other.selectedSectorId, selectedSectorId) || other.selectedSectorId == selectedSectorId)&&(identical(other.selectedLocationId, selectedLocationId) || other.selectedLocationId == selectedLocationId)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_opportunities),meta,links,currentPage,searchQuery,const DeepCollectionEquality().hash(_selectedTags),selectedSectorId,selectedLocationId,isFeatured);

@override
String toString() {
  return 'OpportunitiesState.loaded(opportunities: $opportunities, meta: $meta, links: $links, currentPage: $currentPage, searchQuery: $searchQuery, selectedTags: $selectedTags, selectedSectorId: $selectedSectorId, selectedLocationId: $selectedLocationId, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $OpportunitiesStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Opportunity> opportunities, ApiMeta meta, ApiLinks links, int currentPage, String searchQuery, List<String> selectedTags, int? selectedSectorId, int? selectedLocationId, bool isFeatured
});


$ApiMetaCopyWith<$Res> get meta;$ApiLinksCopyWith<$Res> get links;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of OpportunitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? opportunities = null,Object? meta = null,Object? links = null,Object? currentPage = null,Object? searchQuery = null,Object? selectedTags = null,Object? selectedSectorId = freezed,Object? selectedLocationId = freezed,Object? isFeatured = null,}) {
  return _then(_Loaded(
opportunities: null == opportunities ? _self._opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<Opportunity>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMeta,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as ApiLinks,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedTags: null == selectedTags ? _self._selectedTags : selectedTags // ignore: cast_nullable_to_non_nullable
as List<String>,selectedSectorId: freezed == selectedSectorId ? _self.selectedSectorId : selectedSectorId // ignore: cast_nullable_to_non_nullable
as int?,selectedLocationId: freezed == selectedLocationId ? _self.selectedLocationId : selectedLocationId // ignore: cast_nullable_to_non_nullable
as int?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OpportunitiesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaCopyWith<$Res> get meta {
  
  return $ApiMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of OpportunitiesState
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


class _Error implements OpportunitiesState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of OpportunitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OpportunitiesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $OpportunitiesStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of OpportunitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
