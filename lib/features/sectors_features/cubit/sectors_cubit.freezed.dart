// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sectors_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectorsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SectorsState()';
}


}

/// @nodoc
class $SectorsStateCopyWith<$Res>  {
$SectorsStateCopyWith(SectorsState _, $Res Function(SectorsState) __);
}


/// @nodoc


class _Initial implements SectorsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SectorsState.initial()';
}


}




/// @nodoc


class _Loading implements SectorsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SectorsState.loading()';
}


}




/// @nodoc


class _Loaded implements SectorsState {
  const _Loaded(final  List<Sector> sectors): _sectors = sectors;
  

 final  List<Sector> _sectors;
 List<Sector> get sectors {
  if (_sectors is EqualUnmodifiableListView) return _sectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectors);
}


/// Create a copy of SectorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._sectors, _sectors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sectors));

@override
String toString() {
  return 'SectorsState.loaded(sectors: $sectors)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SectorsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Sector> sectors
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SectorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sectors = null,}) {
  return _then(_Loaded(
null == sectors ? _self._sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<Sector>,
  ));
}


}

/// @nodoc


class _Error implements SectorsState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SectorsState
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
  return 'SectorsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SectorsStateCopyWith<$Res> {
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

/// Create a copy of SectorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SingleLoading implements SectorsState {
  const _SingleLoading(this.sector);
  

 final  Sector sector;

/// Create a copy of SectorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleLoadingCopyWith<_SingleLoading> get copyWith => __$SingleLoadingCopyWithImpl<_SingleLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleLoading&&(identical(other.sector, sector) || other.sector == sector));
}


@override
int get hashCode => Object.hash(runtimeType,sector);

@override
String toString() {
  return 'SectorsState.singleLoading(sector: $sector)';
}


}

/// @nodoc
abstract mixin class _$SingleLoadingCopyWith<$Res> implements $SectorsStateCopyWith<$Res> {
  factory _$SingleLoadingCopyWith(_SingleLoading value, $Res Function(_SingleLoading) _then) = __$SingleLoadingCopyWithImpl;
@useResult
$Res call({
 Sector sector
});


$SectorCopyWith<$Res> get sector;

}
/// @nodoc
class __$SingleLoadingCopyWithImpl<$Res>
    implements _$SingleLoadingCopyWith<$Res> {
  __$SingleLoadingCopyWithImpl(this._self, this._then);

  final _SingleLoading _self;
  final $Res Function(_SingleLoading) _then;

/// Create a copy of SectorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sector = null,}) {
  return _then(_SingleLoading(
null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,
  ));
}

/// Create a copy of SectorsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorCopyWith<$Res> get sector {
  
  return $SectorCopyWith<$Res>(_self.sector, (value) {
    return _then(_self.copyWith(sector: value));
  });
}
}

// dart format on
