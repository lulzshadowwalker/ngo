import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:io';

/// A base repository for Laravel-backed APIs using Dio.
/// Extend this class to implement resource-specific repositories.
///
/// Example:
/// ```dart
/// class LaravelPostsRepository extends LaravelRepository {
///   LaravelPostsRepository({required super.baseUrl, super.dio});
///
///   Future<List<Post>> fetchPosts() async {
///     final data = await get('/posts');
///     return (data as List).map((json) => Post.fromJson(json)).toList();
///   }
/// }
/// ```
abstract class LaravelRepository {
  /// The Dio client to use (can be mocked for testing)
  final Dio dio;

  /// Optionally provide default headers (e.g. for auth)
  Map<String, dynamic> get defaultHeaders => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  LaravelRepository({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              ///   Refactor baseUrl instead of using a hard-coded value.
              baseUrl: "https://sandbox.ngo.lulzie.tech/api/",
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          ) {
    this.dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  /// GET request to [endpoint] with optional [queryParameters] and [headers].
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _request(
      endpoint,
      method: 'GET',
      headers: headers,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request to [endpoint] with optional [data] and [headers].
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic data,
    Options? options,
  }) async {
    return _request(
      endpoint,
      method: 'POST',
      headers: headers,
      data: data,
      options: options,
    );
  }

  /// PUT request to [endpoint] with optional [data] and [headers].
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic data,
    Options? options,
  }) async {
    return _request(
      endpoint,
      method: 'PUT',
      headers: headers,
      data: data,
      options: options,
    );
  }

  /// DELETE request to [endpoint] with optional [headers].
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic data,
    Options? options,
  }) async {
    return _request(
      endpoint,
      method: 'DELETE',
      headers: headers,
      data: data,
      options: options,
    );
  }

  /// PATCH request to [endpoint] with optional [data] and [headers].
  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic data,
    Options? options,
  }) async {
    return _request(
      endpoint,
      method: 'PATCH',
      headers: headers,
      data: data,
      options: options,
    );
  }

  /// PATCH request with multipart form data support for file uploads.
  /// Uses POST with X-HTTP-Method-Override header as required by Laravel for file uploads.
  Future<dynamic> patchMultipart(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    Map<String, File>? files,
  }) async {
    final formData = FormData();

    // Add the method override header for PATCH
    final mergedHeaders = {
      ...defaultHeaders,
      'X-HTTP-Method-Override': 'PATCH',
      if (headers != null) ...headers,
    };

    // Remove Content-Type header to let Dio set it automatically for multipart
    mergedHeaders.remove('Content-Type');

    // Add files to form data
    if (files != null) {
      for (final entry in files.entries) {
        formData.files.add(
          MapEntry(entry.key, await MultipartFile.fromFile(entry.value.path)),
        );
      }
    }

    // Add JSON data as nested form fields
    if (data != null) {
      _addNestedFormData(formData, data, '');
    }

    return _request(
      endpoint,
      method: 'POST', // Using POST with method override
      headers: mergedHeaders,
      data: formData,
    );
  }

  /// Helper method to add nested JSON data to FormData
  void _addNestedFormData(
    FormData formData,
    Map<String, dynamic> data,
    String prefix,
  ) {
    data.forEach((key, value) {
      final fieldName = prefix.isEmpty ? key : '$prefix[$key]';

      if (value is Map<String, dynamic>) {
        _addNestedFormData(formData, value, fieldName);
      } else if (value is List) {
        for (int i = 0; i < value.length; i++) {
          if (value[i] is Map<String, dynamic>) {
            _addNestedFormData(formData, value[i], '$fieldName[$i]');
          } else {
            formData.fields.add(
              MapEntry('$fieldName[$i]', value[i].toString()),
            );
          }
        }
      } else if (value != null) {
        formData.fields.add(MapEntry(fieldName, value.toString()));
      }
    });
  }

  /// Override this to customize error handling or response parsing.
  dynamic processData(dynamic data) => data;

  /// Override this to handle specific status codes yourself.
  /// Return `true` if you handled the response and want to suppress the default error,
  /// or return `false` to let the repository throw.
  ///
  /// For example, you might want to handle 422 validation errors differently.
  /// By default, this does nothing and returns false.
  bool handleStatusCode(Response response) => false;

  /// Internal request handler.
  Future<dynamic> _request(
    String endpoint, {
    required String method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};
    final requestOptions = (options ?? Options()).copyWith(
      method: method,
      headers: mergedHeaders,
    );

    try {
      final response = await dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
      );

      // Allow subclasses to handle specific status codes
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        final handled = handleStatusCode(response);
        if (handled) return null;
        throw LaravelApiException(
          statusCode: response.statusCode!,
          data: response.data,
          uri: response.realUri.toString(),
        );
      }

      return processData(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final handled = handleStatusCode(e.response!);
        if (handled) return null;
        throw LaravelApiException(
          statusCode: e.response?.statusCode ?? 0,
          data: e.response?.data,
          uri: e.response?.realUri.toString(),
        );
      }
      rethrow;
    }
  }
}

/// Exception thrown for non-2xx responses from the Laravel API.
class LaravelApiException implements Exception {
  final int statusCode;
  final dynamic data;
  final String? uri;

  LaravelApiException({required this.statusCode, required this.data, this.uri});

  @override
  String toString() =>
      'LaravelApiException($statusCode, uri: $uri, data: $data)';
}
