import 'package:freezed_annotation/freezed_annotation.dart';

part 'static_page.freezed.dart';

@freezed
abstract class StaticPage with _$StaticPage {
  const StaticPage._();

  const factory StaticPage({
    required String title,
    required String slug,
    required String content,
  }) = _StaticPage;

  factory StaticPage.fromLaravel(Map<String, dynamic> json) {
    return StaticPage(
      title: json['attributes']['title'],
      slug: json['attributes']['slug'],
      content: json['attributes']['content'],
    );
  }
}
