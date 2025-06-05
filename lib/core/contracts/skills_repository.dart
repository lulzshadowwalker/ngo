import 'package:ngo/models/skill.dart';

abstract interface class SkillsRepository {
  Future<List<Skill>> fetchAll({String language});
}
