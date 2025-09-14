// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationResponse {

 String get id; int get formFieldId; String get value; FormField get formField;
/// Create a copy of ApplicationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationResponseCopyWith<ApplicationResponse> get copyWith => _$ApplicationResponseCopyWithImpl<ApplicationResponse>(this as ApplicationResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.formFieldId, formFieldId) || other.formFieldId == formFieldId)&&(identical(other.value, value) || other.value == value)&&(identical(other.formField, formField) || other.formField == formField));
}


@override
int get hashCode => Object.hash(runtimeType,id,formFieldId,value,formField);

@override
String toString() {
  return 'ApplicationResponse(id: $id, formFieldId: $formFieldId, value: $value, formField: $formField)';
}


}

/// @nodoc
abstract mixin class $ApplicationResponseCopyWith<$Res>  {
  factory $ApplicationResponseCopyWith(ApplicationResponse value, $Res Function(ApplicationResponse) _then) = _$ApplicationResponseCopyWithImpl;
@useResult
$Res call({
 String id, int formFieldId, String value, FormField formField
});


$FormFieldCopyWith<$Res> get formField;

}
/// @nodoc
class _$ApplicationResponseCopyWithImpl<$Res>
    implements $ApplicationResponseCopyWith<$Res> {
  _$ApplicationResponseCopyWithImpl(this._self, this._then);

  final ApplicationResponse _self;
  final $Res Function(ApplicationResponse) _then;

/// Create a copy of ApplicationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? formFieldId = null,Object? value = null,Object? formField = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formFieldId: null == formFieldId ? _self.formFieldId : formFieldId // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,formField: null == formField ? _self.formField : formField // ignore: cast_nullable_to_non_nullable
as FormField,
  ));
}
/// Create a copy of ApplicationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormFieldCopyWith<$Res> get formField {
  
  return $FormFieldCopyWith<$Res>(_self.formField, (value) {
    return _then(_self.copyWith(formField: value));
  });
}
}


/// @nodoc


class _ApplicationResponse implements ApplicationResponse {
  const _ApplicationResponse({required this.id, required this.formFieldId, required this.value, required this.formField});
  

@override final  String id;
@override final  int formFieldId;
@override final  String value;
@override final  FormField formField;

/// Create a copy of ApplicationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationResponseCopyWith<_ApplicationResponse> get copyWith => __$ApplicationResponseCopyWithImpl<_ApplicationResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.formFieldId, formFieldId) || other.formFieldId == formFieldId)&&(identical(other.value, value) || other.value == value)&&(identical(other.formField, formField) || other.formField == formField));
}


@override
int get hashCode => Object.hash(runtimeType,id,formFieldId,value,formField);

@override
String toString() {
  return 'ApplicationResponse(id: $id, formFieldId: $formFieldId, value: $value, formField: $formField)';
}


}

/// @nodoc
abstract mixin class _$ApplicationResponseCopyWith<$Res> implements $ApplicationResponseCopyWith<$Res> {
  factory _$ApplicationResponseCopyWith(_ApplicationResponse value, $Res Function(_ApplicationResponse) _then) = __$ApplicationResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, int formFieldId, String value, FormField formField
});


@override $FormFieldCopyWith<$Res> get formField;

}
/// @nodoc
class __$ApplicationResponseCopyWithImpl<$Res>
    implements _$ApplicationResponseCopyWith<$Res> {
  __$ApplicationResponseCopyWithImpl(this._self, this._then);

  final _ApplicationResponse _self;
  final $Res Function(_ApplicationResponse) _then;

/// Create a copy of ApplicationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? formFieldId = null,Object? value = null,Object? formField = null,}) {
  return _then(_ApplicationResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formFieldId: null == formFieldId ? _self.formFieldId : formFieldId // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,formField: null == formField ? _self.formField : formField // ignore: cast_nullable_to_non_nullable
as FormField,
  ));
}

/// Create a copy of ApplicationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormFieldCopyWith<$Res> get formField {
  
  return $FormFieldCopyWith<$Res>(_self.formField, (value) {
    return _then(_self.copyWith(formField: value));
  });
}
}

// dart format on
