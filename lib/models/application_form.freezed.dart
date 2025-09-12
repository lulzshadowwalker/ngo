// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationForm {

 int get id; String get title; String? get description; bool get isActive; List<FormField> get formFields; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ApplicationForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationFormCopyWith<ApplicationForm> get copyWith => _$ApplicationFormCopyWithImpl<ApplicationForm>(this as ApplicationForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationForm&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.formFields, formFields)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isActive,const DeepCollectionEquality().hash(formFields),createdAt,updatedAt);

@override
String toString() {
  return 'ApplicationForm(id: $id, title: $title, description: $description, isActive: $isActive, formFields: $formFields, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ApplicationFormCopyWith<$Res>  {
  factory $ApplicationFormCopyWith(ApplicationForm value, $Res Function(ApplicationForm) _then) = _$ApplicationFormCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description, bool isActive, List<FormField> formFields, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ApplicationFormCopyWithImpl<$Res>
    implements $ApplicationFormCopyWith<$Res> {
  _$ApplicationFormCopyWithImpl(this._self, this._then);

  final ApplicationForm _self;
  final $Res Function(ApplicationForm) _then;

/// Create a copy of ApplicationForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? isActive = null,Object? formFields = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,formFields: null == formFields ? _self.formFields : formFields // ignore: cast_nullable_to_non_nullable
as List<FormField>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _ApplicationForm implements ApplicationForm {
  const _ApplicationForm({required this.id, required this.title, this.description, required this.isActive, required final  List<FormField> formFields, required this.createdAt, required this.updatedAt}): _formFields = formFields;
  

@override final  int id;
@override final  String title;
@override final  String? description;
@override final  bool isActive;
 final  List<FormField> _formFields;
@override List<FormField> get formFields {
  if (_formFields is EqualUnmodifiableListView) return _formFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formFields);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ApplicationForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationFormCopyWith<_ApplicationForm> get copyWith => __$ApplicationFormCopyWithImpl<_ApplicationForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationForm&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._formFields, _formFields)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isActive,const DeepCollectionEquality().hash(_formFields),createdAt,updatedAt);

@override
String toString() {
  return 'ApplicationForm(id: $id, title: $title, description: $description, isActive: $isActive, formFields: $formFields, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ApplicationFormCopyWith<$Res> implements $ApplicationFormCopyWith<$Res> {
  factory _$ApplicationFormCopyWith(_ApplicationForm value, $Res Function(_ApplicationForm) _then) = __$ApplicationFormCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description, bool isActive, List<FormField> formFields, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ApplicationFormCopyWithImpl<$Res>
    implements _$ApplicationFormCopyWith<$Res> {
  __$ApplicationFormCopyWithImpl(this._self, this._then);

  final _ApplicationForm _self;
  final $Res Function(_ApplicationForm) _then;

/// Create a copy of ApplicationForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? isActive = null,Object? formFields = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ApplicationForm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,formFields: null == formFields ? _self._formFields : formFields // ignore: cast_nullable_to_non_nullable
as List<FormField>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
