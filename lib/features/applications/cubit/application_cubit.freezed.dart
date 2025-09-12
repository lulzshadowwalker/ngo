// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState()';
}


}

/// @nodoc
class $ApplicationStateCopyWith<$Res>  {
$ApplicationStateCopyWith(ApplicationState _, $Res Function(ApplicationState) __);
}


/// @nodoc


class _Initial implements ApplicationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.initial()';
}


}




/// @nodoc


class _Checking implements ApplicationState {
  const _Checking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Checking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.checking()';
}


}




/// @nodoc


class _CanApply implements ApplicationState {
  const _CanApply();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CanApply);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.canApply()';
}


}




/// @nodoc


class _AlreadyApplied implements ApplicationState {
  const _AlreadyApplied(this.application);
  

 final  Application application;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlreadyAppliedCopyWith<_AlreadyApplied> get copyWith => __$AlreadyAppliedCopyWithImpl<_AlreadyApplied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlreadyApplied&&(identical(other.application, application) || other.application == application));
}


@override
int get hashCode => Object.hash(runtimeType,application);

@override
String toString() {
  return 'ApplicationState.alreadyApplied(application: $application)';
}


}

/// @nodoc
abstract mixin class _$AlreadyAppliedCopyWith<$Res> implements $ApplicationStateCopyWith<$Res> {
  factory _$AlreadyAppliedCopyWith(_AlreadyApplied value, $Res Function(_AlreadyApplied) _then) = __$AlreadyAppliedCopyWithImpl;
@useResult
$Res call({
 Application application
});


$ApplicationCopyWith<$Res> get application;

}
/// @nodoc
class __$AlreadyAppliedCopyWithImpl<$Res>
    implements _$AlreadyAppliedCopyWith<$Res> {
  __$AlreadyAppliedCopyWithImpl(this._self, this._then);

  final _AlreadyApplied _self;
  final $Res Function(_AlreadyApplied) _then;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? application = null,}) {
  return _then(_AlreadyApplied(
null == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application,
  ));
}

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationCopyWith<$Res> get application {
  
  return $ApplicationCopyWith<$Res>(_self.application, (value) {
    return _then(_self.copyWith(application: value));
  });
}
}

/// @nodoc


class _Submitting implements ApplicationState {
  const _Submitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.submitting()';
}


}




/// @nodoc


class _Submitted implements ApplicationState {
  const _Submitted(this.application);
  

 final  Application application;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedCopyWith<_Submitted> get copyWith => __$SubmittedCopyWithImpl<_Submitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted&&(identical(other.application, application) || other.application == application));
}


@override
int get hashCode => Object.hash(runtimeType,application);

@override
String toString() {
  return 'ApplicationState.submitted(application: $application)';
}


}

/// @nodoc
abstract mixin class _$SubmittedCopyWith<$Res> implements $ApplicationStateCopyWith<$Res> {
  factory _$SubmittedCopyWith(_Submitted value, $Res Function(_Submitted) _then) = __$SubmittedCopyWithImpl;
@useResult
$Res call({
 Application application
});


$ApplicationCopyWith<$Res> get application;

}
/// @nodoc
class __$SubmittedCopyWithImpl<$Res>
    implements _$SubmittedCopyWith<$Res> {
  __$SubmittedCopyWithImpl(this._self, this._then);

  final _Submitted _self;
  final $Res Function(_Submitted) _then;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? application = null,}) {
  return _then(_Submitted(
null == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application,
  ));
}

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationCopyWith<$Res> get application {
  
  return $ApplicationCopyWith<$Res>(_self.application, (value) {
    return _then(_self.copyWith(application: value));
  });
}
}

/// @nodoc


class _Saving implements ApplicationState {
  const _Saving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Saving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.saving()';
}


}




/// @nodoc


class _SavedAsDraft implements ApplicationState {
  const _SavedAsDraft();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedAsDraft);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApplicationState.savedAsDraft()';
}


}




/// @nodoc


class _Error implements ApplicationState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ApplicationState
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
  return 'ApplicationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ApplicationStateCopyWith<$Res> {
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

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
