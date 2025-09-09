

import 'package:ngo/models/sectors.dart';

abstract interface class SectorsRepository {
  Future<List<Sector>> fetchAll({String language});
  Future<Sector> fetch(String slug, {String language});

}
