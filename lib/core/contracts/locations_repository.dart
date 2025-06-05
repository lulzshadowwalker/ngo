import 'package:ngo/models/location.dart';

abstract interface class LocationsRepository {
  Future<List<Location>> fetchAll({String language});
  Future<Location> fetch(String id, {String language});
}
