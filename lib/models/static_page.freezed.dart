// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'static_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaticPage {

 String get title; String get slug; String get content;
/// Create a copy of StaticPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaticPageCopyWith<StaticPage> get copyWith => _$StaticPageCopyWithImpl<StaticPage>(this as StaticPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaticPage&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,title,slug,content);

@override
String toString() {
  return 'StaticPage(title: $title, slug: $slug, content: $content)';
}


}

/// @nodoc
abstract mixin class $StaticPageCopyWith<$Res>  {
  factory $StaticPageCopyWith(StaticPage value, $Res Function(StaticPage) _then) = _$StaticPageCopyWithImpl;
@useResult
$Res call({
 String title, String slug, String content
});




}
/// @nodoc
class _$StaticPageCopyWithImpl<$Res>
    implements $StaticPageCopyWith<$Res> {
  _$StaticPageCopyWithImpl(this._self, this._then);

  final StaticPage _self;
  final $Res Function(StaticPage) _then;

/// Create a copy of StaticPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? slug = null,Object? content = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _StaticPage extends StaticPage {
  const _StaticPage({required this.title, required this.slug, required this.content}): super._();
  

@override final  String title;
@override final  String slug;
@override final  String content;

/// Create a copy of StaticPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaticPageCopyWith<_StaticPage> get copyWith => __$StaticPageCopyWithImpl<_StaticPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaticPage&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,title,slug,content);

@override
String toString() {
  return 'StaticPage(title: $title, slug: $slug, content: $content)';
}


}

/// @nodoc
abstract mixin class _$StaticPageCopyWith<$Res> implements $StaticPageCopyWith<$Res> {
  factory _$StaticPageCopyWith(_StaticPage value, $Res Function(_StaticPage) _then) = __$StaticPageCopyWithImpl;
@override @useResult
$Res call({
 String title, String slug, String content
});




}
/// @nodoc
class __$StaticPageCopyWithImpl<$Res>
    implements _$StaticPageCopyWith<$Res> {
  __$StaticPageCopyWithImpl(this._self, this._then);

  final _StaticPage _self;
  final $Res Function(_StaticPage) _then;

/// Create a copy of StaticPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? slug = null,Object? content = null,}) {
  return _then(_StaticPage(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
