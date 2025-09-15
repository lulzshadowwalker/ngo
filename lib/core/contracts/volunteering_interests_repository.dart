import 'package:ngo/models/volunteering_interest.dart';

abstract interface class VolunteeringInterestsRepository {
  Future<List<VolunteeringInterest>> fetchAll({String language});
  Future<VolunteeringInterest> fetch(String id, {String language});
}
