import 'package:ngo/core/contracts/locations_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/location.dart';

final class LaravelLocationsRepository extends LaravelRepository
    implements LocationsRepository {

  @override
  Future<List<Location>> fetchAll({String language = 'en'}) async {
    final response = await get('/$language/locations');

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Location.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Location> fetch(String id, {String language = 'en'}) async {
    final response = await get('/$language/locations/$id');
    final data = response['data'] as Map<String, dynamic>;
    return Location.fromLaravel(data);
  }
}
