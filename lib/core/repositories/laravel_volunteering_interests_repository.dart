import 'dart:developer';

import 'package:ngo/core/contracts/volunteering_interests_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/volunteering_interest.dart';

final class LaravelVolunteeringInterestsRepository extends LaravelRepository
    implements VolunteeringInterestsRepository {
  @override
  Future<List<VolunteeringInterest>> fetchAll({String language = 'en'}) async {
    log('LaravelVolunteeringInterestsRepository: Fetching volunteeringInterests with language: $language');

    final response = await get(
      '/v1/volunteering-interests',
      headers: {'Accept-Language': language},
    );

    log('LaravelVolunteeringInterestsRepository: Response received: $response');

    final data = response['data'] as List<dynamic>;
    log('LaravelVolunteeringInterestsRepository: Found ${data.length} volunteeringInterests');

    return data
        .map((item) => VolunteeringInterest.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<VolunteeringInterest> fetch(String id, {String language = 'en'}) async {
    final response = await get(
      '/v1/volunteering-interests/$id',
      headers: {'Accept-Language': language},
    );
    final data = response['data'] as Map<String, dynamic>;
    return VolunteeringInterest.fromLaravel(data);
  }
}
