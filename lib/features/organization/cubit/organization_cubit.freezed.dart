// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationState()';
}


}

/// @nodoc
class $OrganizationStateCopyWith<$Res>  {
$OrganizationStateCopyWith(OrganizationState _, $Res Function(OrganizationState) __);
}


/// @nodoc


class _Initial implements OrganizationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationState.initial()';
}


}




/// @nodoc


class _Loading implements OrganizationState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationState.loading()';
}


}




/// @nodoc


class _Loaded implements OrganizationState {
  const _Loaded(final  List<Organization> organizations): _organizations = organizations;
  

 final  List<Organization> _organizations;
 List<Organization> get organizations {
  if (_organizations is EqualUnmodifiableListView) return _organizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_organizations);
}


/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._organizations, _organizations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_organizations));

@override
String toString() {
  return 'OrganizationState.loaded(organizations: $organizations)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $OrganizationStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Organization> organizations
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? organizations = null,}) {
  return _then(_Loaded(
null == organizations ? _self._organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<Organization>,
  ));
}


}

/// @nodoc


class _LoadedSingleOrganization implements OrganizationState {
  const _LoadedSingleOrganization(this.organization);
  

 final  Organization organization;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedSingleOrganizationCopyWith<_LoadedSingleOrganization> get copyWith => __$LoadedSingleOrganizationCopyWithImpl<_LoadedSingleOrganization>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedSingleOrganization&&(identical(other.organization, organization) || other.organization == organization));
}


@override
int get hashCode => Object.hash(runtimeType,organization);

@override
String toString() {
  return 'OrganizationState.loadedSingleOrgnization(organization: $organization)';
}


}

/// @nodoc
abstract mixin class _$LoadedSingleOrganizationCopyWith<$Res> implements $OrganizationStateCopyWith<$Res> {
  factory _$LoadedSingleOrganizationCopyWith(_LoadedSingleOrganization value, $Res Function(_LoadedSingleOrganization) _then) = __$LoadedSingleOrganizationCopyWithImpl;
@useResult
$Res call({
 Organization organization
});


$OrganizationCopyWith<$Res> get organization;

}
/// @nodoc
class __$LoadedSingleOrganizationCopyWithImpl<$Res>
    implements _$LoadedSingleOrganizationCopyWith<$Res> {
  __$LoadedSingleOrganizationCopyWithImpl(this._self, this._then);

  final _LoadedSingleOrganization _self;
  final $Res Function(_LoadedSingleOrganization) _then;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? organization = null,}) {
  return _then(_LoadedSingleOrganization(
null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as Organization,
  ));
}

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationCopyWith<$Res> get organization {
  
  return $OrganizationCopyWith<$Res>(_self.organization, (value) {
    return _then(_self.copyWith(organization: value));
  });
}
}

/// @nodoc


class _Error implements OrganizationState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of OrganizationState
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
  return 'OrganizationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $OrganizationStateCopyWith<$Res> {
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

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
