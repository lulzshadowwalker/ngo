// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FormField {

 int get id; FormFieldType get type; String get label; String? get placeholder; String? get helpText; List<String>? get options; Map<String, dynamic>? get validationRules; bool get isRequired; int get sortOrder;
/// Create a copy of FormField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFieldCopyWith<FormField> get copyWith => _$FormFieldCopyWithImpl<FormField>(this as FormField, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormField&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.placeholder, placeholder) || other.placeholder == placeholder)&&(identical(other.helpText, helpText) || other.helpText == helpText)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.validationRules, validationRules)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,label,placeholder,helpText,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(validationRules),isRequired,sortOrder);

@override
String toString() {
  return 'FormField(id: $id, type: $type, label: $label, placeholder: $placeholder, helpText: $helpText, options: $options, validationRules: $validationRules, isRequired: $isRequired, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $FormFieldCopyWith<$Res>  {
  factory $FormFieldCopyWith(FormField value, $Res Function(FormField) _then) = _$FormFieldCopyWithImpl;
@useResult
$Res call({
 int id, FormFieldType type, String label, String? placeholder, String? helpText, List<String>? options, Map<String, dynamic>? validationRules, bool isRequired, int sortOrder
});




}
/// @nodoc
class _$FormFieldCopyWithImpl<$Res>
    implements $FormFieldCopyWith<$Res> {
  _$FormFieldCopyWithImpl(this._self, this._then);

  final FormField _self;
  final $Res Function(FormField) _then;

/// Create a copy of FormField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? label = null,Object? placeholder = freezed,Object? helpText = freezed,Object? options = freezed,Object? validationRules = freezed,Object? isRequired = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FormFieldType,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,placeholder: freezed == placeholder ? _self.placeholder : placeholder // ignore: cast_nullable_to_non_nullable
as String?,helpText: freezed == helpText ? _self.helpText : helpText // ignore: cast_nullable_to_non_nullable
as String?,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,validationRules: freezed == validationRules ? _self.validationRules : validationRules // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _FormField implements FormField {
  const _FormField({required this.id, required this.type, required this.label, this.placeholder, this.helpText, final  List<String>? options, final  Map<String, dynamic>? validationRules, required this.isRequired, required this.sortOrder}): _options = options,_validationRules = validationRules;
  

@override final  int id;
@override final  FormFieldType type;
@override final  String label;
@override final  String? placeholder;
@override final  String? helpText;
 final  List<String>? _options;
@override List<String>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _validationRules;
@override Map<String, dynamic>? get validationRules {
  final value = _validationRules;
  if (value == null) return null;
  if (_validationRules is EqualUnmodifiableMapView) return _validationRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  bool isRequired;
@override final  int sortOrder;

/// Create a copy of FormField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormFieldCopyWith<_FormField> get copyWith => __$FormFieldCopyWithImpl<_FormField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormField&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.placeholder, placeholder) || other.placeholder == placeholder)&&(identical(other.helpText, helpText) || other.helpText == helpText)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._validationRules, _validationRules)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,label,placeholder,helpText,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_validationRules),isRequired,sortOrder);

@override
String toString() {
  return 'FormField(id: $id, type: $type, label: $label, placeholder: $placeholder, helpText: $helpText, options: $options, validationRules: $validationRules, isRequired: $isRequired, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$FormFieldCopyWith<$Res> implements $FormFieldCopyWith<$Res> {
  factory _$FormFieldCopyWith(_FormField value, $Res Function(_FormField) _then) = __$FormFieldCopyWithImpl;
@override @useResult
$Res call({
 int id, FormFieldType type, String label, String? placeholder, String? helpText, List<String>? options, Map<String, dynamic>? validationRules, bool isRequired, int sortOrder
});




}
/// @nodoc
class __$FormFieldCopyWithImpl<$Res>
    implements _$FormFieldCopyWith<$Res> {
  __$FormFieldCopyWithImpl(this._self, this._then);

  final _FormField _self;
  final $Res Function(_FormField) _then;

/// Create a copy of FormField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? label = null,Object? placeholder = freezed,Object? helpText = freezed,Object? options = freezed,Object? validationRules = freezed,Object? isRequired = null,Object? sortOrder = null,}) {
  return _then(_FormField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FormFieldType,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,placeholder: freezed == placeholder ? _self.placeholder : placeholder // ignore: cast_nullable_to_non_nullable
as String?,helpText: freezed == helpText ? _self.helpText : helpText // ignore: cast_nullable_to_non_nullable
as String?,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,validationRules: freezed == validationRules ? _self._validationRules : validationRules // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
