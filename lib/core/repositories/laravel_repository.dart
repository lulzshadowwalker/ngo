import 'package:dio/dio.dart';

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
          );

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
