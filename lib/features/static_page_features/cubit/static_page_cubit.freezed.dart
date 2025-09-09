// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'static_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaticPageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaticPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StaticPageState()';
}


}

/// @nodoc
class $StaticPageStateCopyWith<$Res>  {
$StaticPageStateCopyWith(StaticPageState _, $Res Function(StaticPageState) __);
}


/// @nodoc


class _Initial implements StaticPageState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StaticPageState.initial()';
}


}




/// @nodoc


class _Loading implements StaticPageState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StaticPageState.loading()';
}


}




/// @nodoc


class _Success implements StaticPageState {
  const _Success(this.staticPage);
  

 final  StaticPage staticPage;

/// Create a copy of StaticPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.staticPage, staticPage) || other.staticPage == staticPage));
}


@override
int get hashCode => Object.hash(runtimeType,staticPage);

@override
String toString() {
  return 'StaticPageState.success(staticPage: $staticPage)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $StaticPageStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 StaticPage staticPage
});


$StaticPageCopyWith<$Res> get staticPage;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of StaticPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? staticPage = null,}) {
  return _then(_Success(
null == staticPage ? _self.staticPage : staticPage // ignore: cast_nullable_to_non_nullable
as StaticPage,
  ));
}

/// Create a copy of StaticPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StaticPageCopyWith<$Res> get staticPage {
  
  return $StaticPageCopyWith<$Res>(_self.staticPage, (value) {
    return _then(_self.copyWith(staticPage: value));
  });
}
}

/// @nodoc


class _Error implements StaticPageState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of StaticPageState
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
  return 'StaticPageState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $StaticPageStateCopyWith<$Res> {
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

/// Create a copy of StaticPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
