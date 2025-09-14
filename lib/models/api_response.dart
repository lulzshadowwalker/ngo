import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
abstract class ApiMeta with _$ApiMeta {
  const factory ApiMeta({
    required int total,
    required int perPage,
    required int currentPage,
    required int lastPage,
    required int from,
    required int to,
  }) = _ApiMeta;

  factory ApiMeta.fromJson(Map<String, dynamic> json) {
    return ApiMeta(
      total: json['total'] as int? ?? 0,
      perPage: json['perPage'] as int? ?? 20,
      currentPage: json['currentPage'] as int? ?? 1,
      lastPage: json['lastPage'] as int? ?? 1,
      from: json['from'] as int? ?? 1,
      to: json['to'] as int? ?? 0,
    );
  }
}

@freezed
abstract class ApiLinks with _$ApiLinks {
  const factory ApiLinks({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) = _ApiLinks;

  factory ApiLinks.fromJson(Map<String, dynamic> json) {
    return ApiLinks(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }
}

@freezed
abstract class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required List<T> data,
    required ApiMeta meta,
    required ApiLinks links,
  }) = _PaginatedResponse<T>;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      meta: ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
      links: ApiLinks.fromJson(json['links'] as Map<String, dynamic>),
    );
  }
}
