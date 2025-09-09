import 'package:ngo/core/contracts/sectors_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/sectors.dart';

final class LaravelSectorRepository extends LaravelRepository
    implements SectorsRepository {
  @override
  Future<Sector> fetch(String slug, {String language = 'en'}) async {
    final response = await get(
      '/v1/sectors/$slug',
      headers: {'Accept-Language': language},
    );
    final data = response['data'] as Map<String, dynamic>;
    return Sector.fromLaravel(data);
  }

  @override
  Future<List<Sector>> fetchAll({String language = 'en'}) async {
    final response = await get(
      '/v1/sectors',
      headers: {'Accept-Language': language},
    );

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Sector.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }




}
